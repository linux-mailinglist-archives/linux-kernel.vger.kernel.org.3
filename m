Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C66588520
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiHCAYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHCAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:24:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0743A4A7;
        Tue,  2 Aug 2022 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659486282; x=1691022282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I+3KYuApKw+1SaJBfFLOfhT/etsF0JXMQZdFhUMlH+k=;
  b=DV1Iarx54l5QHDW2pG3g6XBqCpLjY75df0HUHAVX/U6Yxlyu3ylqeP0E
   2NZ7yBd54FjMpZRphzb2vZTITry2Fekp/t0VjCW7BMNhB7sMwX6ejPR5G
   2pjMlzyAvJgVE4oIw/3nSzQO0ArdIkK70Y7ubEm7JIzaZrT8DFZ0t+dmr
   /5RxSoXM2LmDZ25fm2s2RDHc9MqsyFMwViENBMHCkynF6wQbLWbEdixrp
   kbtVm8KDdSNc0EhMI9H0y/mqpTdEhn+Iz5xb/ViVCrgn94g3Ys+xJTISM
   YcQ9/hnMRejfZCCUgcVYwqt+/KQjtNhmw7R8luFqUcgYH2AhHzwU0Nvfk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="315404089"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="315404089"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 17:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="602630625"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2022 17:24:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ2Bj-000GbL-1D;
        Wed, 03 Aug 2022 00:24:39 +0000
Date:   Wed, 3 Aug 2022 08:24:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Utkarsh Verma <utkarshverma294@gmail.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     kbuild-all@lists.01.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: Re: [PATCH] docs: checkpatch: add some new checkpatch documentation
 messages
Message-ID: <202208030829.xj2bvI7P-lkp@intel.com>
References: <20220802055528.13726-1-utkarshverma294@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802055528.13726-1-utkarshverma294@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on lwn/docs-next]
[also build test ERROR on linus/master v5.19 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Utkarsh-Verma/docs-checkpatch-add-some-new-checkpatch-documentation-messages/20220802-135802
base:   git://git.lwn.net/linux.git docs-next
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> Documentation/dev-tools/checkpatch.rst:1393: (SEVERE/4) Unexpected section title or transition.
>> Documentation/dev-tools/checkpatch.rst:1393: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/dev-tools/checkpatch.rst:1393: WARNING: Unexpected section title or transition.

vim +1393 Documentation/dev-tools/checkpatch.rst

  1302	
  1303	  **CONFIG_DESCRIPTION**
  1304	    Kconfig symbols should have a help text which fully describes
  1305	    it.
  1306	
  1307	  **CORRUPTED_PATCH**
  1308	    The patch seems to be corrupted or lines are wrapped.
  1309	    Please regenerate the patch file before sending it to the maintainer.
  1310	
  1311	  **CVS_KEYWORD**
  1312	    Since linux moved to git, the CVS markers are no longer used.
  1313	    So, CVS style keywords ($Id$, $Revision$, $Log$) should not be
  1314	    added.
  1315	
  1316	  **DEFAULT_NO_BREAK**
  1317	    switch default case is sometimes written as "default:;".  This can
  1318	    cause new cases added below default to be defective.
  1319	
  1320	    A "break;" should be added after empty default statement to avoid
  1321	    unwanted fallthrough.
  1322	
  1323	  **DOS_LINE_ENDINGS**
  1324	    For DOS-formatted patches, there are extra ^M symbols at the end of
  1325	    the line.  These should be removed.
  1326	
  1327	  **DT_SCHEMA_BINDING_PATCH**
  1328	    DT bindings moved to a json-schema based format instead of
  1329	    freeform text.
  1330	
  1331	    See: https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-schema.html
  1332	
  1333	  **DT_SPLIT_BINDING_PATCH**
  1334	    Devicetree bindings should be their own patch.  This is because
  1335	    bindings are logically independent from a driver implementation,
  1336	    they have a different maintainer (even though they often
  1337	    are applied via the same tree), and it makes for a cleaner history in the
  1338	    DT only tree created with git-filter-branch.
  1339	
  1340	    See: https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
  1341	
  1342	  **EMBEDDED_FILENAME**
  1343	    Embedding the complete filename path inside the file isn't particularly
  1344	    useful as often the path is moved around and becomes incorrect.
  1345	
  1346	  **FILE_PATH_CHANGES**
  1347	    Whenever files are added, moved, or deleted, the MAINTAINERS file
  1348	    patterns can be out of sync or outdated.
  1349	
  1350	    So MAINTAINERS might need updating in these cases.
  1351	
  1352	  **MEMSET**
  1353	    The memset use appears to be incorrect.  This may be caused due to
  1354	    badly ordered parameters.  Please recheck the usage.
  1355	
  1356	  **MISORDERED_TYPE**
  1357	    According to section “6.7.2 Type Specifiers” in C90 standard, “type
  1358	    specifiers may occur in any order.” This means that "signed long long
  1359	    int" is same as "long long int signed". But to avoid confusion and make
  1360	    the code easier to read, the declaration type should use the following
  1361	    format::
  1362	
  1363	      [[un]signed] [short|int|long|long long]
  1364	
  1365	    Below is the list of standard integer types. Each row lists all the
  1366	    different ways of specifying a particular type delimited by commas.
  1367	    Note: Also include all the permutations of a particular type
  1368	    on the left column delimited by comma. For example, the permutations
  1369	    for "signed long int" are "signed int long", "long signed int",
  1370	    "long int signed", "int signed long", and "int long signed".
  1371	
  1372	    +--------------------------------------------------+--------------------+
  1373	    |                       Types                      |   Recommended Way  |
  1374	    +=======================================================================+
  1375	    | char                                             | char               |
  1376	    +-----------------------------------------------------------------------+
  1377	    | signed char                                      | signed char        |
  1378	    +-----------------------------------------------------------------------+
  1379	    | unsigned char                                    | unsigned char      |
  1380	    +-----------------------------------------------------------------------+
  1381	    | signed, int, signed int                          | int                |
  1382	    +-----------------------------------------------------------------------+
  1383	    | unsigned, unsigned int                           | unsigned int       |
  1384	    +-----------------------------------------------------------------------+
  1385	    | short, signed short, short int, signed short int | short              |
  1386	    +-----------------------------------------------------------------------+
  1387	    | unsigned short, unsigned short int               | unsigned short     |
  1388	    +-----------------------------------------------------------------------+
  1389	    | long, signed long, long int, signed long int     | long               |
  1390	    +-----------------------------------------------------------------------+
  1391	    | unsigned long, unsigned long int                 | unsigned long      |
  1392	    +-----------------------------------------------------------------------|
> 1393	    | long long, signed long long, long long int,      | long long          |

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
