Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801DF4B9AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbiBQINc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:13:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiBQINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:13:23 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65EE22528
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:13:05 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220217081303epoutp0404bfd82be3a1f0aa9cd54255d75f5ba7~UhJ87kBgl0162201622epoutp04M
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:13:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220217081303epoutp0404bfd82be3a1f0aa9cd54255d75f5ba7~UhJ87kBgl0162201622epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645085583;
        bh=CkVdxlzMdliZMV9QfR+AVMkX96BMbtByMo/P+XXlvBQ=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=qB7Pbyjkqm9FllKqtPwLCwxhzKIkhSv7e0+y1ZhYxFJCDpO8t+dVEdn8UMS9NbK7O
         rXaV/j3QPmXH9wKTP335B3sEQD7uCcQatnuF95s/mVFzbbnzZ7cG4UdhRMv4cmnb3V
         ipQMOgcNxfhO0wd1XZN6t4Dd3IS1nVwi9NNdZplI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220217081302epcas2p4c769763743bcb16454ae027c4b629391~UhJ8N6qao1133311333epcas2p46;
        Thu, 17 Feb 2022 08:13:02 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jznd66Nsfz4x9Pq; Thu, 17 Feb
        2022 08:12:58 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.66.51767.A830E026; Thu, 17 Feb 2022 17:12:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220217081258epcas2p1bf98958f272c660541af370aed799b18~UhJ4JOTO32222622226epcas2p1U;
        Thu, 17 Feb 2022 08:12:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220217081258epsmtrp1af4a766ce4ff4c9e145a36adab31f588~UhJ4AmEXl3184931849epsmtrp1I;
        Thu, 17 Feb 2022 08:12:58 +0000 (GMT)
X-AuditID: b6c32a45-45dff7000000ca37-d9-620e038aa170
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.75.08738.A830E026; Thu, 17 Feb 2022 17:12:58 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.18.123]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220217081257epsmtip18e8e9ee6671e636aba27f08a52bf7769~UhJ3xfZWS2002520025epsmtip1c;
        Thu, 17 Feb 2022 08:12:57 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Bean Huo'" <huobean@gmail.com>,
        "'Adrian Hunter'" <adrian.hunter@intel.com>,
        "'Avri Altman'" <Avri.Altman@wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <cang@codeaurora.org>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <bhoon95.kim@samsung.com>, <vkumar.1997@samsung.com>
In-Reply-To: <1cb4db5f707692afedb005e2577f667f5e48e66e.camel@gmail.com>
Subject: RE: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Date:   Thu, 17 Feb 2022 17:12:57 +0900
Message-ID: <015601d823d6$2c44f5c0$84cee140$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI4IgZMS69T+T+3eQm0GbWo6Fi0ygFitYZoAa2Aj1kCJc0N+wFVhb0mAUlYJFoCaybGMauFZ3Zw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmqW4XM1+SwbmZlhYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLeacbWCyWL34AYvFohvbmCwu75rDZtF9fQebxfLj/5gs
        uu7eYLRY+u8ti8Wd+x9ZHPg9Lvf1MnnsnHWX3WPxnpdMHhMWHWD0+L6+g83j49NbLB59W1Yx
        enzeJOfRfqCbKYAzKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+gFJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5e
        aomVoYGBkSlQYUJ2RvPS68wFv5gqDnxrZmlg3MTUxcjJISFgInGy+RVzFyMXh5DADkaJlh+7
        GCGcT4wSjyccZ4FwPjNKnHl/nhGmZfmcNqiqXYwS0zpPMEE4L4H6921lBqliE9CWmPZwNytI
        QkRgN7PE1zWfwNo5BdwlWj53sILYwgKxEje2X2cDsVkEVCV6fs0Cs3kFLCXaF+5kgbAFJU7O
        fAJmMwMNXbbwNTPEGQoSP58uA5sjIhAl0dDcxghRIyIxu7MN7CMJgTscEhcmvmeFaHCROLvz
        EZQtLPHq+BZ2CFtK4mV/G5DNAWQXS2zaJw/R28AoseTTZhaIGmOJWc/aGUFqmAU0Jdbv0oco
        V5Y4cgvqND6JjsN/oabwSnS0CUE0Kkv8mjQZGnCSEjNv3oEq8ZDoXJQ1gVFxFpIfZyH5cRaS
        X2YhrF3AyLKKUSy1oDg3PbXYqMAQHtnJ+bmbGMGpW8t1B+Pktx/0DjEycTAeYpTgYFYS4f1w
        kDdJiDclsbIqtSg/vqg0J7X4EKMpMNQnMkuJJucDs0deSbyhiaWBiZmZobmRqYG5kjivV8qG
        RCGB9MSS1OzU1ILUIpg+Jg5OqQamao6Jt5Ov6J2NbQx9o7324MUN+/e+dGA06ZmQdKjz8d65
        kR/XHF+dFbAt57/p74VJSlcmf80qadHn9HJanT7LccEpodncv7K3KUTadF7sCnlv9sBGmGWm
        2rn4MxM+m6mvYuzb6bzF+m59zenCsuUWNfttmF0su+c1q3oauPSJfuNk5ErWuc4o+2mCa0jq
        Xbk3l+sD+zPr9Rn7jp2YvFckJvdB9tyK7Av2gmGrf0+16Lhce1B4X/aTMEPt0LtBGvWXjDRi
        /rcov1qQ0aPIe9BORcy1Uz5JqcE8L1ru3w6uhosRdbNfbnys/nse98bCRC2l1zZ7Xkt/fnPX
        /Y6N9sYDr2cp7mTjaUyLzcg7dFuJpTgj0VCLuag4EQDWFhalZgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSnG4XM1+Swa5WFouTT9awWTyYt43N
        4uXPq2wWBx92slh8XfqM1eLT+mWsFnPONjBZrF78gMVi0Y1tTBaXd81hs+i+voPNYvnxf0wW
        XXdvMFos/feWxeLO/Y8sDvwel/t6mTx2zrrL7rF4z0smjwmLDjB6fF/fwebx8ektFo++LasY
        PT5vkvNoP9DNFMAZxWWTkpqTWZZapG+XwJWx4PtxloJ/TBWrD81gamDcxNTFyMkhIWAisXxO
        G2MXIxeHkMAORolLKxYxQyQkJU7sfM4IYQtL3G85wgpiCwk8Z5RYM9kXxGYT0JaY9nA3K0iz
        iMBpZonZ166zQkzawCyxdeUvsBWcAu4SLZ87wLqFBaIltk/4CRZnEVCV6Pk1iw3E5hWwlGhf
        uJMFwhaUODnzCZjNDLSh92ErI4y9bOFrqOsUJH4+XQY2U0QgSqKhuQ2qRkRidmcb8wRGoVlI
        Rs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHLFaWjsY96z6
        oHeIkYmD8RCjBAezkgjvh4O8SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1O
        TS1ILYLJMnFwSjUw2f0t5n/edeZlc9Ws/fbl++absgtv333Ps1ZKq5rxkcqZrZ0Ri75EW9lv
        bd15Zevs+C7FtovHzxycrCA3YbtUmGFw6fnkCt+Zkf4l+9kXRL1vWbLB1mapQG31K/GHp1d9
        2vV+f92HkIXeLKwzvhm1LXQoyJFQKOidXM2jZGFhPv+wRouc7ten0oz5unsWvbA+f1p5m2iE
        a0l9xgQl/89+nidq/vQ9cT+23dLvhtPVKqcbYSY/y98V280t9imqE5g/84blvJkbJd/cOGN2
        sa/152HNJ3/5NTza4wJ1uo/9tvx104O/bSeTrfKX9c0ZUYZWV/9s3nNhxWX2R3Jr+E549E6f
        bZHczRfleu7d/6g4JZbijERDLeai4kQArTaqL0cDAAA=
X-CMS-MailID: 20220217081258epcas2p1bf98958f272c660541af370aed799b18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220205074128epcas2p40901c37a7328e825d8697f8d3269edba
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
        <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
        <DM6PR04MB657519E60FAFA19434531CE2FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
        <007101d81eed$4d120a60$e7361f20$@samsung.com>
        <3f2938f7-2a9e-60e8-5237-fe7ebc3b4296@intel.com>
        <000001d81fcb$3b962f30$b2c28d90$@samsung.com>
        <1cb4db5f707692afedb005e2577f667f5e48e66e.camel@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The name of clk_scaling_lock has explained everything, for the platform
> which doesn't support load-based clk scaling, doesn't need to hold this
> lock.
>=20
> Acked-by: Bean Huo <beanhuo=40micron.com>

Okay, thank you for your information.
I still have no idea of why the lock is required for ufshcd_exec_dev_cmd fr=
om the UFS specification w/o any featuring.


