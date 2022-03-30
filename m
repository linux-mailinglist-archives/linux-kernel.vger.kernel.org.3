Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155314EBBAD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbiC3HY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiC3HYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:24:46 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4341117E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:22:36 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220330072233epoutp0216bb07b4f3296602136a8eb6bab2806c~hF6j1_YG42012420124epoutp02o
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:22:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220330072233epoutp0216bb07b4f3296602136a8eb6bab2806c~hF6j1_YG42012420124epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648624953;
        bh=5bBI6q2wZWo3XcexjTRdUZ7wvKovmJIxuLm9HARnyk0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=VeXjBJfDsbiBABCAv/SxV46xcmLbTzWHluS4c45dTJSvqid4ba6CEzlHylvqT5kXV
         iPWgFW48lLfXNCMECfANElyL4XWODeSO1zLM9gZXvmJBK16E8kEQBAS0VOtbAjyk06
         9TLG+yp2AFXOzNFtQEQgPdL+tSBWkuwzrooqf2y0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220330072232epcas1p1131eefe4438b6804ed6cfcdfc1c5c3c6~hF6jhdXiT0966609666epcas1p1g;
        Wed, 30 Mar 2022 07:22:32 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.240]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KSyYz2Lczz4x9Qr; Wed, 30 Mar
        2022 07:22:31 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-7f-624405372e92
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.D6.21932.73504426; Wed, 30 Mar 2022 16:22:31 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 0/8] memblock: introduce memsize showing reserved memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YkQB6Ah603yPR3qf@kernel.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220330072230epcms1p87c4b557f88fe166f339dfa72eb96ec8c@epcms1p8>
Date:   Wed, 30 Mar 2022 16:22:30 +0900
X-CMS-MailID: 20220330072230epcms1p87c4b557f88fe166f339dfa72eb96ec8c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmnq45q0uSwdy9ghZz1q9hs3h5SNOi
        e/NMRove96+YLC7vmsNmcW/Nf1aLI+u3M1nMbuxjtHi8ntuB02PnrLvsHptWdbJ5bPo0id3j
        xIzfLB59W1YxepxZcITd4/MmuQD2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sL
        cyWFvMTcVFslF58AXbfMHKDDlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFZgV6
        xYm5xaV56Xp5qSVWhgYGRqZAhQnZGbM71rAVvBeu+LD+NGsD433+LkZODgkBE4kVfZ1sXYxc
        HEICOxgl2o/dZe5i5ODgFRCU+LtDGKRGWMBH4n3TLHYQW0hASeLsjyvsEHFdiabu1SwgNpuA
        tsT7BZNYQWwRAWWJ74v3MYPMZBZYyiSx4UYTM8QyXokZ7U9ZIGxpie3LtzKC2JwCWhJ9R58z
        QcRFJW6ufssOY78/Np8RwhaRaL13FmqOoMSDn7uh4lIS57qPM4HcLCEQIfFijzpEOEfi/c45
        rBC2ucSzDS1gI3kFfCXOnbkFtopFQFVi/q43UKtcJFZM+wQ2kllAXmL72zngYGAW0JRYv0sf
        okRRYufvuYwwnzRs/M2OzmYW4JN497WHFSa+Y94TqK/UJFqefYWKy0j8/feMdQKj0ixEQM9C
        sngWwuIFjMyrGMVSC4pz01OLDQtM4HGbnJ+7iRGcRLUsdjDOfftB7xAjEwfjIUYJDmYlEd6P
        B52ThHhTEiurUovy44tKc1KLDzGaAr08kVlKNDkfmMbzSuINTSwNTMyMTCyMLY3NlMR5e6ee
        ThQSSE8sSc1OTS1ILYLpY+LglGpgYpT0NFrYwl3xPfttUW9j+03ODwEdFXGcruKfNk7hqN3k
        KPH+4hOGPT8r8uOZbUX+P6pdNedGaveLvSd/7z3LsC976y7mnSvuLTIR23V6Qv/uWclbFt1Q
        m3Gi7vG12LvHtVlqbmUKVkuViKg//fFQp4OlqWD9u4MXj6RsUAq0jFyVV/w1bNKuouzcc83P
        GvZZej5gEdJ7EPNoqfii1Spbd1X8Ws2Q5r294EJT4ULNvczbWDPT36s6M6cKhNfW5pUqrPz9
        xf7/7a/FVRbNZ1eYxW4T3f64MGF5bvfnio5XB1x21s4y01LJ/HF1hcrKUL9jgkXfNQJncQSq
        vmmQkdDxvJ/HY9ZcXXv1Ruqyx7zJSizFGYmGWsxFxYkAjPhhOCsEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8
References: <YkQB6Ah603yPR3qf@kernel.org> <YkB/gzP6tOpDktoZ@kernel.org>
        <YkAU2JlcX7nlvbwp@kernel.org> <Yj1zVkryTVoAnxsX@kernel.org>
        <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <20220325083846epcms1p372559472ceb511cc45d39c110563063a@epcms1p3>
        <20220327135347epcms1p13faf0f2b7d98d3b59b25e903678d9c48@epcms1p1>
        <20220329024620epcms1p7633018e83f54e532761008a60da5254f@epcms1p7>
        <CGME20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8@epcms1p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>On Tue, Mar 29, 2022 at 11:46:20AM +0900, Jaewon Kim wrote:
>> >> > 
>> >> >I'm still not following. The reserved region sizes are available in the
>> >> >existing memblock debugfs.
>> >> >Why the names are important? What is the value of having names for *some*
>> >> >of the reserved regions?
>> >> 
>> >> Hi
>> >> 
>> >> There are many memory regions in memblock debugfs memory/reserved, and some might
>> >> be splited or merged with other region. Among regions in debugfs, we can't find 
>> >> the one we defined in device tree. Especially it is difficult to find the region we
>> >> described size only without start address.
>> >> 
>> >> On mobile environment, memory is used by not only CPU but also GPU, Camera, Secure
>> >> world, Audio, ETC. To support them, there are many reserved regions described in
>> >> device tree. So the name is quite important to recognize a region. And with thename
>> >> we can compare reserved memory map with other map.
>> >
>> >You still didn't describe your use case. What is the problem your patches
>> >are trying to solve? Why is it important to know what is the use of particular
>> >reserved region? 
>> >
>> >You propose complex mechanism that seems to fit very particular scenario
>> >and sprinkle some calls to this mechanism at random places because you need
>> >to "compare reserved memory map with other map".
>> >
>> >Does not sound convincing to me, sorry.
>> 
>> As I said serveral times, I want a simple knob showing all reserved
>> memory status.  The current debugfs, device tree do not show all those
>> information I want. I think you also know that.  i.e. late freed pages,
>> splited or merged memblock, address defined at boot time, kernel size,
>> ETC. 
>
>I know that there is not much information about reserved memory exposed and
>I understand *what* are you trying to achieve. But you never provided
>details about *why* you want this information exposed.
>
>I don't mind providing more visibility into reserved memory attributes in
>general, but I'd like to see something way more simple and localized.
>

I think the "what" is same as "why".
I want to look at all reservced memory status simply in a knob.

I also want to make in more simple and localized way, but there seems be
several ways to change reserved memory such as cmdline way, freeing after
boot, etc. I wanted to cover all those things.

That's OK. I hope someone later to try this again to show all the info.

>-- 
>Sincerely yours,
>Mike.
