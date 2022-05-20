Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF352E147
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbiETAjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbiETAjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:39:01 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E92A131281
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:38:59 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220520003853epoutp013c8130544a1817e4159d6605a261f39e~wqTrhjDlV3267032670epoutp01M
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:38:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220520003853epoutp013c8130544a1817e4159d6605a261f39e~wqTrhjDlV3267032670epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653007133;
        bh=5NMI7MorGMmG97q1ul08ajIeM0aOU20dl08vI5qrh8c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vHthYb1ieIuPByo+SXQNyBi52iYEYEOW1QWRlENqUTrN9E+CicDhFMx3FjPS39c2A
         63MQuFFrncZXjW3fueY/LeDGIiQySzoVu9ZZRtPRnI4u3m9WHnq/yp2e69knyxpm7+
         t9iAA1P8CNAWkMmeZkMxm9vJCEBhuUnD+cexoXt8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220520003853epcas1p20b3ffcd617e3439610fd588b7a935e91~wqTrSZzyU2348723487epcas1p20;
        Fri, 20 May 2022 00:38:53 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.235]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L47Bg6r2xz4x9Pr; Fri, 20 May
        2022 00:38:51 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.F6.09785.B13E6826; Fri, 20 May 2022 09:38:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220520003851epcas1p1542dc1328f88ee1ac13e8bb8d49ef364~wqTplGxWv0695006950epcas1p1D;
        Fri, 20 May 2022 00:38:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220520003851epsmtrp10e1fcb2aa8ae1425c6aa5e24e849aa5f~wqTpkOGq-1074010740epsmtrp1U;
        Fri, 20 May 2022 00:38:51 +0000 (GMT)
X-AuditID: b6c32a36-c87ff70000002639-ac-6286e31ba827
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.35.08924.B13E6826; Fri, 20 May 2022 09:38:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220520003851epsmtip17c812aed18a84625a19d49a63cff0db5~wqTpXlHVb2793627936epsmtip1f;
        Fri, 20 May 2022 00:38:51 +0000 (GMT)
Subject: Re: [GIT PULL] extcon next for 5.19
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <316a4c19-b164-a8a5-3643-ec8f5930db68@samsung.com>
Date:   Fri, 20 May 2022 10:05:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <YoZagTAVe1WQb6n+@kroah.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTQFf6cVuSwZMec4uJN66wWDw7qm3R
        vHg9m8XlXXPYLG43rmBzYPXYOesuu8emVZ1sHvvnrmH36NuyitHj8ya5ANaobJuM1MSU1CKF
        1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoN1KCmWJOaVAoYDE4mIl
        fTubovzSklSFjPziElul1IKUnALTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMiy332Qt+M1U8
        vnuHsYFxOVMXIyeHhICJROv7hyxdjFwcQgI7GCUevf3MBOF8YpQ4dG8nVOYzo0Tf6VOsMC0L
        3+9hhkjsYpQ486EJquo9o8SlhkcsIFXCAjoSPR332EFsEYEIidvHzoHNZRboYpRoXrILbBSb
        gJbE/hc32EBsfgFFias/HjOC2LwCdhKvlswAG8QioCox88xWsEGiAmESJ7e1QNUISpyc+QSs
        hlNAU+LTlG1gNcwC4hK3nsxngrDlJba/nQN2qoRAL4fE6jN3gBZzADkuErcO50O8Iyzx6vgW
        dghbSuJlfxs7RH0zo0TDi9uMEE4Po8TRZ30sEFXGEvuXTmYCGcQMtHn9Ln2IsKLEzt9zGSEW
        80m8+9oDtYtXoqNNCKJEWeLyg7vQkJeUWNzeyTaBUWkWkndmIXlhFpIXZiEsW8DIsopRLLWg
        ODc9tdiwwAge38n5uZsYwSlTy2wH46S3H/QOMTJxMB5ilOBgVhLhZcxtSRLiTUmsrEotyo8v
        Ks1JLT7EaAoM4InMUqLJ+cCknVcSb2hiaWBiZmRsYmFoZqgkzrtq2ulEIYH0xJLU7NTUgtQi
        mD4mDk6pBqbKxwe7JcUMjVwuvwg4v+jmxw7fHzt3XRXfU9j2cQnbPTWdi623X+U/ZK8reLjo
        WJoPm/NCnyUM2Z6hdlOXOrL7zb0seNX7xT8e0x/9X97/OsJePJ3D41ruTfdVbw5tvBn1pIZp
        q4vSbMusd3v8d6QtLstrqxWxjNEVdNCffNb5Ux2bf8RLRt+Lbx0TexecOWWa2v5MPHRb+xuL
        OHNzz1lR+/9l1u7hv6x+xfK8UtuUyd/Dub2/Vv5uSwuKiauceXdxS5Xix61JOhe2n33aM2dH
        bWq992nujV4Sc4NYDmw/fi098nLq9e0rVrY3/z6m0zb/nbzLuZL7OwpufZgur5SwYdmVSf1N
        UzzlfsmsP/NFiaU4I9FQi7moOBEAkwvIMSIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnK7047Ykg5tHJS0m3rjCYvHsqLZF
        8+L1bBaXd81hs7jduILNgdVj56y77B6bVnWyeeyfu4bdo2/LKkaPz5vkAlijuGxSUnMyy1KL
        9O0SuDIuttxnL/jNVPH47h3GBsblTF2MnBwSAiYSC9/vYe5i5OIQEtjBKLH4z3x2iISkxLSL
        R4ESHEC2sMThw8UQNW8ZJf6vOM4IUiMsoCPR03EPrF5EIELi1ro5TCBFzAJdjBL3bjxnheh4
        xCix/mEzWBWbgJbE/hc32EBsfgFFias/HoNN4hWwk3i1ZAYLiM0ioCox88xWsHpRgTCJnUse
        M0HUCEqcnPkErIZTQFPi05RtYDXMAuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPwLCTts5C0
        zELSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMGxo6W1g3HPqg96hxiZ
        OBgPMUpwMCuJ8DLmtiQJ8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUI
        JsvEwSnVwOQffPjGK+npOw9+7HpT7pQlNjfnYiVHvnAZm1ZvXLHqzOCKiZY/1weaT13ycv4z
        wXidlu4ph1R2GT844Kc6be0cFkbm2zvLXnNz7Yh6HKUceblhqcqrYvefLq1blE7cOBbtZvDN
        +tPrCQv4V+75kKMoL7p+yaXwrY/md/2ZJHHDsTC/QvTAbmbuybd7meTvPF2UKcjwW+n6turD
        HwxYP+p1v/3Suf/lgSBv7weW7OER3j06sxaYrIvIrN/8LTSD55gZt7y6rLDVjETTP019atY6
        90LtvGb7dqRvOKGdkPX/g5nin0s5m7cePt3VUxpfcyLg5IK7aV9Cu6aeuVYn9PAOW590U8Dc
        0PMPfq09LqbEUpyRaKjFXFScCAAUg/e6DAMAAA==
X-CMS-MailID: 20220520003851epcas1p1542dc1328f88ee1ac13e8bb8d49ef364
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220519150019epcas1p28ef56fb480ecbc553544543a2ea29c5b
References: <eaab9f4d-06d4-3ddc-3756-69f762bd86e1@gmail.com>
        <3aa73483-19d6-fc25-a3c6-03343582b542@gmail.com>
        <CGME20220519150019epcas1p28ef56fb480ecbc553544543a2ea29c5b@epcas1p2.samsung.com>
        <YoZagTAVe1WQb6n+@kroah.com>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 11:56 PM, Greg Kroah-Hartman wrote:
> On Wed, May 18, 2022 at 03:03:48AM +0900, Chanwoo Choi wrote:
>> Dear Greg,
>>
>> Gently ping. Could you please pull this request?
> 
> Sorry, was behind in patches, catching up now...
> 

You're welcome. I'll send the pull request more early on next.
Thank you

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
