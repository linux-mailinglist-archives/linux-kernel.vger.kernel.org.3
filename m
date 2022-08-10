Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0A58E938
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiHJJBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiHJJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:01:06 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115136F57F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:01:04 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220810090100epoutp0330cdbde405e10dd404495f0ae6f183ee~J8DfwF2x-3043130431epoutp03Q
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:01:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220810090100epoutp0330cdbde405e10dd404495f0ae6f183ee~J8DfwF2x-3043130431epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660122060;
        bh=KbeBxIzTLNIWRe5IYA9cswHWLNutgMsrvlyBZOJkBFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gd/XZLb8FtUpbj2u3mOjaC2Aivs42wsMU3KztJMuNdeHBFqwW8G1Wp6o4V/RKEZm+
         nyt29tD55/OwfUJD/bp02zET5kmCffs9oMOH7/GAm8ttJI1hx7M7thB+FhUe9VvCcZ
         fIh0T1HLvdzwkHqJurdhQEiUg0/yvDCAXX8G/nFE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220810090100epcas1p18cc7926e37ef41847592a1e911915ab4~J8DfQZBXS1069510695epcas1p1a;
        Wed, 10 Aug 2022 09:01:00 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.145]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4M2kSC0fp8z4x9Q1; Wed, 10 Aug
        2022 09:00:59 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.7C.09967.AC373F26; Wed, 10 Aug 2022 18:00:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220810090058epcas1p346589365aad7bae18b85a201e7d5ec8b~J8DdxzR8d2541925419epcas1p3B;
        Wed, 10 Aug 2022 09:00:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220810090058epsmtrp1d7606db11a1757bc8c57ed7933ee2138~J8DdrrEsO2721327213epsmtrp1q;
        Wed, 10 Aug 2022 09:00:58 +0000 (GMT)
X-AuditID: b6c32a38-4a3ff700000226ef-20-62f373cad2b6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.B1.08905.AC373F26; Wed, 10 Aug 2022 18:00:58 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220810090058epsmtip1e6127b9a62604a39caf83f99d69766bf~J8DdanLpJ0927609276epsmtip1f;
        Wed, 10 Aug 2022 09:00:58 +0000 (GMT)
Date:   Wed, 10 Aug 2022 18:00:58 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: New subsystem for acceleration devices
Message-Id: <20220810180058.48cfbbcfdf5b8b7f19ce26b4@samsung.com>
In-Reply-To: <CAFCwf13WU3ZEjurEaEnVC56zorwKr-uuQn-ec10r301Fh+XEtA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmru6p4s9JBjf6rSxOXF/EZPF30jF2
        iytf37NZNC9ez2Zx5d8eRovLu+awWVx4cZvV4srzAAcOj9+/JjF67Jx1l91j/9w17B73u48z
        efQ2v2PzuLXa2OPzJrkA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BaYFesWJucWl
        eel6eaklVoYGBkamQIUJ2RkHGwwL9vJW/Jx8mbmB8RhXFyMnh4SAicSph/+Zuxi5OIQEdjBK
        NP3rZIdwPjFKnD17HCrzjVHi6fUHjDAtN99/garayyixZstyFging0liYetSIIeDg0VAVeLM
        rGiQBjYgc+aMNewgtoiAusS1fT1sIPXMAjuZJO6de8UEkhAWMJY4u/M3G4jNK+AosaFjIVic
        UyBQYteCJ2wQmy0k7vasYAWZzysgKPF3hzBImFlAXmL72zlgl0oITOSQWHR6AQtEvYvEgwu3
        oa4Wlnh1fAs7hC0l8bK/DcrOlpjSsQiqvkDi3POtzCDzJYDuubgiBcRkFtCUWL9LH6JCUWLn
        77mMEGv5JN597WGFqOaV6GgTgihRkljy5zDUcAmJqTO+MUHYHhINy3cwQkJqKqvEj2tb2SYw
        KsxCeGYWkmdmISxewMi8ilEstaA4Nz212LDABB69yfm5mxjBCVTLYgfj3Lcf9A4xMnEwHmKU
        4GBWEuE9svZ9khBvSmJlVWpRfnxRaU5q8SFGU2DMTGSWEk3OB6bwvJJ4QxNLAxMzI2MTC0Mz
        QyVx3t6ppxOFBNITS1KzU1MLUotg+pg4OKUamPQ/LxC8FaAb8V7WaYbpjCTZG7FRMoWyza2+
        DDN2eC1nNb3PaWY/abJq+us5jXI/X1zays3J8HKHkO9OP7fQe5UBBl9sjX1UYnasv/Xs9p78
        Iw/sjjBwfPwRnHzD7HeoQeyKalaH5bJLQpkvzXc2+/fJTvfS6u9/Lis/2BcSk/Sw8m1tzIe9
        RoFT5hdt32D+Qva13L8qezFr313b0/2jUp/0yjvkpb3csiO+7PzEI0yn680fi5RydLX5rlww
        6++7LvXef8d1OySn1N3UY7nd8PKfGqN90JXeGZO/yhs8uNGTv9vpZ+Gb47oP5UzTb6ZM5fWz
        9MqVKJyo+O2M7u2oF/eY3hyRnLZRLTbxRWXydiWW4oxEQy3mouJEAHyGBaQpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnO6p4s9JBjtXilucuL6IyeLvpGPs
        Fle+vmezaF68ns3iyr89jBaXd81hs7jw4jarxZXnAQ4cHr9/TWL02DnrLrvH/rlr2D3udx9n
        8uhtfsfmcWu1scfnTXIB7FFcNimpOZllqUX6dglcGQcbDAv28lb8nHyZuYHxGFcXIyeHhICJ
        xM33X9i7GLk4hAR2M0os+bucDSIhIbHp3nLmLkYOIFtY4vDhYoiaNiaJ5gXHwOIsAqoSZ2ZF
        g5SzAZkzZ6xhB7FFBNQlru3rYQOpZxbYySTxY0UrK0hCWMBY4uzO32DzeQUcJTZ0LGQCsTkF
        AiV2LXjCBrFgKqvEj2tboY6wkLjbs4IVZBmvgKDE3x3CIGFmAS2Jh79usUDY8hLb385hnsAo
        OAuhahaSqllIqhYwMq9ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiODS3NHYzbV33Q
        O8TIxMF4iFGCg1lJhPfI2vdJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5N
        LUgtgskycXBKNTDt4tNTTnHcvuCcbV+J/8yC+S8Zcy9xFz589J/rXMthBpV3rbZ5igaTDdbY
        Oj6Qzw/W/vJjfkle9vWyH5/S3u7Y/4RJReRgSav38aNrZ/dV/3/0bst0DrbI6+qqk5L2e/40
        E0hm4VaVf71X6+rZtnOCZb8M65Q47zgqnAu/0PDpcgtzuaiazv8gsUmbwh/MW7SrO3pfWvKP
        SQ+ebLLJ6ny3yak8Y9dHXzND1Vm1b4r/3ljXskZxjqBB7deFzAl1P+rmOgdNyDDZuXrbgc1d
        s34EHGm/q37Gyn+CdMzVJeu/272o68nslPwxobdnzzbhVRuNm6aH+FU33jzEFuEYK5M085FZ
        yLPp+VPDHsYr6QsrsRRnJBpqMRcVJwIAKF8defwCAAA=
X-CMS-MailID: 20220810090058epcas1p346589365aad7bae18b85a201e7d5ec8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220809214255epcas1p2608fb28462f5f2cea028f71ea0899887
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
        <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
        <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
        <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
        <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com>
        <CAPM=9txme2dQD9kyM6gnYyXL34hYP8wcGMbduOUcFsKe+4zTcQ@mail.gmail.com>
        <CAFCwf11TPKTF_Ndi60FneWp5g3SoawJvfJoKVWJ-QjxjpawMmg@mail.gmail.com>
        <CGME20220809214255epcas1p2608fb28462f5f2cea028f71ea0899887@epcas1p2.samsung.com>
        <CAFCwf13WU3ZEjurEaEnVC56zorwKr-uuQn-ec10r301Fh+XEtA@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 00:42:24 +0300
Oded Gabbay <oded.gabbay@gmail.com> wrote:

> 
> Hi Jiho, Yuji.
> 
> I want to update that I'm currently in discussions with Dave to figure
> out what's the best way to move forward. We are writing it down to do
> a proper comparison between the two paths (new accel subsystem or
> using drm). I guess it will take a week or so.
> 
> In the meantime, I'm putting the accel code on hold. I have only
> managed to do the very basic infra and add a demo driver that shows
> how to register and unregister from it.
> You can check the code at:
> https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/log/?h=accel
> 
> It has two commits. The first adds the subsystem code and the second
> adds the demo driver.
> The subsystem code is basically drm code copied and renamed and
> slightly modified, but I really only worked on it for a couple of
> hours so take that into consideration.
> 
> The important thing is that the demo driver shows the basic steps are
> really simple. You need to add two function calls in your probe and
> one function call in your release. Of course you will need to supply
> some function callbacks, but I haven't got to fill that in the demo
> driver. Once you register, you get /dev/accel/ac0 and
> /dev/accel/ac_controlD64 (if you want a control device). If I were to
> continue this, the next step is to do the open and close part.
> 
> I will update once we know where things are heading. As I said, I
> imagine it can take a few weeks.
> 
> Thanks,
> Oded
> 

Hi Oded,
Thanks for sharing your code, it looks good start from basic drm code.
I hope the discussion makes better result.

Thanks,
Jiho Chu

