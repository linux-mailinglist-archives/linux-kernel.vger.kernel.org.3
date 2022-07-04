Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1401E564BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiGDCo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGDCoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:44:24 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFC8F38
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 19:44:20 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220704024416epoutp0308492951bf035317703240f4a019aced~_gC-wr3D72253822538epoutp03d
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:44:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220704024416epoutp0308492951bf035317703240f4a019aced~_gC-wr3D72253822538epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656902656;
        bh=n8Kw2Rs2lC534VOksvXxadz8DaQjYrclcY87Zd0TzLU=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=NrWRledK0/MGN/nTVNwBhfcotEtOglyMzbNIDxGwsmrUzV6VF+plHKzS32ftW6RtP
         reh26yj4jjlthnBM5/qnZeWWPYUIZKSN3IgFzZ9szIbif3zea1m5fbYSjqGJVwOf3O
         kOGDAJhvk+e4n7DUfYPbNqh2FDKFSTbwGlGCNOss=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220704024415epcas2p4e5fe5f2e9ee072bb31e3f4e1bfe95272~_gC-Evqtk2455324553epcas2p4-;
        Mon,  4 Jul 2022 02:44:15 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lbqrb1BR8z4x9Pv; Mon,  4 Jul
        2022 02:44:15 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-65-62c253ffd5ba
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.9A.09666.FF352C26; Mon,  4 Jul 2022 11:44:15 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v3 1/2] scsi: ufs: wb: renaming & cleanups functions
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <DM6PR04MB65752CFFE4E5BD0D9C1DB8F4FCBF9@DM6PR04MB6575.namprd04.prod.outlook.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220704024414epcms2p206c70583f57d8df4f41f36a1e686475a@epcms2p2>
Date:   Mon, 04 Jul 2022 11:44:14 +0900
X-CMS-MailID: 20220704024414epcms2p206c70583f57d8df4f41f36a1e686475a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhe7/4ENJBm9PsFucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZJ2/tYS24xFbxcf4DlgbGHyxdjJwc
        EgImEjsPfgayuTiEBHYwSjzt2sbYxcjBwSsgKPF3hzBIjbCAt0Tr2lfMILaQgJLEuTWzwEqE
        BQwkbvWag4TZBPQkfi6ZwQYyRkTgMLPEyitdUPN5JWa0P4WypSW2L9/KCGJzCsRKrGhsZ4KI
        a0j8WNbLDGGLStxc/ZYdxn5/bD4jhC0i0XrvLFSNoMSDn7uh4pIShw59ZQO5R0IgX2LDgUCI
        cI3E2+UHoEr0Ja51bAQ7gVfAV2LO9TNgcRYBVYnXp75AneYi0XkOYhWzgLzE9rdzmEFGMgto
        SqzfpQ8xXVniyC24pxo2/mZHZzML8El0HP4LF98x7wkTRKuaxKImI4iwjMTXw/PZJzAqzUKE
        8iwka2chrF3AyLyKUSy1oDg3PbXYqMAQHrHJ+bmbGMEpVct1B+Pktx/0DjEycTAeYpTgYFYS
        4V016WCSEG9KYmVValF+fFFpTmrxIUZToIcnMkuJJucDk3peSbyhiaWBiZmZobmRqYG5kjiv
        V8qGRCGB9MSS1OzU1ILUIpg+Jg5OqQYm9Q8GvRu/MWQlbmJVX/Vr3SsLviir/W5+Zy7YTX69
        zuG19uO96wWE5/qXX98oZeWy60Wv2yq1WaLSLR+kre+z1l8IfW3UPtFvyodbD27WTvTt3LVb
        805VSPS9bXuFlYumPpzEbcRxfC/bpWkiMpMfuxdv/+42Nc7QcMbNkPO6bmFyGa0xt/K3PCpf
        7PKt9n29M6cMs/OyHZP0M2+ve+uodfeu0b83a596lDSpCf84rGzcLLV/bqHbviv7VgacO913
        2adm2b68umWdM01K219a7PJgDDBp21hSs1DzpczJ1Y/6fz1J2h0/0eJgYQbPwxuVAXud1bk7
        +oTmZoor+cvWW05nZv2pe26etswWw1kHlFiKMxINtZiLihMBzkSjZjIEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95
References: <DM6PR04MB65752CFFE4E5BD0D9C1DB8F4FCBF9@DM6PR04MB6575.namprd04.prod.outlook.com>
        <20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p4>
        <20220701074654epcms2p5fcc0a8abe766fa00851b00dff98ad3c7@epcms2p5>
        <CGME20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p2>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -5715,6 +5715,9 @@ static int __ufshcd_wb_toggle(struct ufs_hba *hba,
>> bool set, enum flag_idn idn)
>>         enum query_opcode opcode = set ? UPIU_QUERY_OPCODE_SET_FLAG :
>>                                    UPIU_QUERY_OPCODE_CLEAR_FLAG;
>> 
>> +       if (!ufshcd_is_wb_allowed(hba))
>> +               return -EPERM;
>> +
>>         index = ufshcd_wb_get_query_index(hba);
>>         return ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);  } @@ -
>> 5723,60 +5726,50 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool
>> enable)  {
> Nobody is checking the return value of ufshcd_wb_toggle(), maybe make it void instead?
>
> Other than that - looks good to me.
>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

It is used in "wb_on_store()" that turns WB on/off.

Thank you for your review. :)

Jinyoung.
