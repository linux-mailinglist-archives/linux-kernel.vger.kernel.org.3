Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53A454FE34
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiFQURu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jun 2022 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiFQURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:17:45 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C376590
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:17:41 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 16DC835035;
        Fri, 17 Jun 2022 20:17:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 8E8DD20028;
        Fri, 17 Jun 2022 20:17:38 +0000 (UTC)
Message-ID: <7690845ccf9597e8cdc560a674a1b8e79a10f680.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update DW 8250 UART maintainership
From:   Joe Perches <joe@perches.com>
To:     kernel test robot <lkp@intel.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@lists.01.org, Jiri Slaby <jirislaby@kernel.org>
Date:   Fri, 17 Jun 2022 13:17:37 -0700
In-Reply-To: <202206180451.ZfYLcA43-lkp@intel.com>
References: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com>
         <202206180451.ZfYLcA43-lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: pbog3x85gq1cobzmnqoha4o9cmj7co9g
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 8E8DD20028
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/nGVMfHLzejJeiYLF6cqjyZLYVB9hcTkg=
X-HE-Tag: 1655497058-955313
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-06-18 at 04:09 +0800, kernel test robot wrote:
> Hi "Ilpo,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.19-rc2 next-20220617]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ilpo-J-rvinen/MAINTAINERS-Update-DW-8250-UART-maintainership/20220617-174145
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 47700948a4abb4a5ae13ef943ff682a7f327547a
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> > > 'utf-8' codec can't decode byte 0xe4 in position 1396: invalid continuation byte

?

false positive?

