Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803C04EA56C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiC2CsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiC2CsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:48:11 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AADD1A5D5F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:46:29 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220329024626epoutp014d375ffaaf28d177525031947cc4f9d6~gugMuQTQI0566005660epoutp01b
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:46:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220329024626epoutp014d375ffaaf28d177525031947cc4f9d6~gugMuQTQI0566005660epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648521986;
        bh=Jb0zVmXE6FZXq1tlAr4YAjL1vUog6bxPPj7i8N6C7MI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=I2uy2rU3LvZ93uIQ/KckuVybhE+uY5dYpXE32/MV/MoS4rSCTbUovh61TNsu+3nuP
         yJyk5yargmtBF3PkN24wFzKuUlAHUfmGX0qjTN9BLJ/a3+eFex/Vu4uRydXu51oUSr
         frYMP6xCqgCPWfXk0SzCTFoOdKbioJbWleGyk7wM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220329024625epcas1p43212b4fb9e4759d1232d065af0dcf4fa~gugMPIIzR0984209842epcas1p45;
        Tue, 29 Mar 2022 02:46:25 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.250]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KSDTr31Pmz4x9Pt; Tue, 29 Mar
        2022 02:46:24 +0000 (GMT)
X-AuditID: b6c32a36-203ff70000002055-2f-624272fc68a2
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.69.08277.CF272426; Tue, 29 Mar 2022 11:46:20 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 0/8] memblock: introduce memsize showing reserved memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YkB/gzP6tOpDktoZ@kernel.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220329024620epcms1p7633018e83f54e532761008a60da5254f@epcms1p7>
Date:   Tue, 29 Mar 2022 11:46:20 +0900
X-CMS-MailID: 20220329024620epcms1p7633018e83f54e532761008a60da5254f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmru6fIqckgylLDS3mrF/DZvHykKZF
        9+aZjBa9718xWVzeNYfN4t6a/6wWR9ZvZ7KY3djHaPF4PbcDp8fOWXfZPTat6mTz2PRpErvH
        iRm/WTz6tqxi9Diz4Ai7x+dNcgHsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW
        5koKeYm5qbZKLj4Bum6ZOUCHKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAr0
        ihNzi0vz0vXyUkusDA0MjEyBChOyM54eXspSsJy/4u6Tp8wNjDN5uhg5OSQETCSmTD/P1sXI
        xSEksINR4u7MS8xdjBwcvAKCEn93CIPUCAv4SLxvmsUOYgsJKEmc/XGFHSKuK9HUvZoFxGYT
        0JZ4v2ASK0iriICXxJ23HiAjmQWWMklsuNHEDLGLV2JG+1MWCFtaYvvyrYwgNqeAlsSO/Z1Q
        cVGJm6vfssPY74/NZ4SwRSRa752FmiMo8eDnbqi4lMS57uNMIHslBCIkXuxRhwjnSLzfOYcV
        wjaXeLahBWwkr4CvRN/Ss2wgNouAqsTuuQehVrlI3Fh7CWwks4C8xPa3c8ChwCygKbF+lz5E
        iaLEzt9zGWE+adj4mx2dzSzAJ/Huaw8rTHzHvCdMELaaRMuzr1BxGYm//56xTmBUmoUI51lI
        Fs9CWLyAkXkVo1hqQXFuemqxYYERPGqT83M3MYJTqJbZDsZJbz/oHWJk4mA8xCjBwawkwit7
        1j5JiDclsbIqtSg/vqg0J7X4EKMp0MsTmaVEk/OBSTyvJN7QxNLAxMzIxMLY0thMSZx31bTT
        iUIC6YklqdmpqQWpRTB9TBycUg1MZZV1psIW2ZXVQpHrH2u3rT/0q9eu8XyMl5Od2pR/k+em
        7TH8tnxutX/99M3uV75eWC6nf/zvxz52zQn3/vinpa+M8p1pePZR0teiTRkKJkfeG0+oqYi+
        q3/79FeGE2a/mBXS3p7jnvA3N66kKju+nrU9tW6potOzwj+zXCYd4Oz+1nuxYcM/yT+Bjcvk
        +hQWe9X1iNzaGLT1UDaHY/2KHwKbd8kw7BU+8fjNL1fmu55F6jefljL56N7eteDEql3JX+ak
        TeJXbu4tZ9g19clmX5GrGke2LOgruHDKeU3BFul3pyd86Y+VFks8Zh5qkWP8ZMnqlHiji0K+
        8llshesYZu/xEFzo4Zz8xKHc9CyTEktxRqKhFnNRcSIAZ9gvfCoEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8
References: <YkB/gzP6tOpDktoZ@kernel.org> <YkAU2JlcX7nlvbwp@kernel.org>
        <Yj1zVkryTVoAnxsX@kernel.org>
        <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <20220325083846epcms1p372559472ceb511cc45d39c110563063a@epcms1p3>
        <20220327135347epcms1p13faf0f2b7d98d3b59b25e903678d9c48@epcms1p1>
        <CGME20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8@epcms1p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> > 
>> >--------- Original Message ---------
>> >Sender : Mike Rapoport <rppt@kernel.org>
>> >Date : 2022-03-27 16:40 (GMT+9)
>> >Title : Re: [PATCH 0/8] memblock: introduce memsize showing reserved memory
>> > 
>> > 
>> >I'm still not following. The reserved region sizes are available in the
>> >existing memblock debugfs.
>> >Why the names are important? What is the value of having names for *some*
>> >of the reserved regions?
>> 
>> Hi
>> 
>> There are many memory regions in memblock debugfs memory/reserved, and some might
>> be splited or merged with other region. Among regions in debugfs, we can't find 
>> the one we defined in device tree. Especially it is difficult to find the region we
>> described size only without start address.
>> 
>> On mobile environment, memory is used by not only CPU but also GPU, Camera, Secure
>> world, Audio, ETC. To support them, there are many reserved regions described in
>> device tree. So the name is quite important to recognize a region. And with thename
>> we can compare reserved memory map with other map.
>
>You still didn't describe your use case. What is the problem your patches
>are trying to solve? Why is it important to know what is the use of particular
>reserved region? 
>
>You propose complex mechanism that seems to fit very particular scenario
>and sprinkle some calls to this mechanism at random places because you need
>to "compare reserved memory map with other map".
>
>Does not sound convincing to me, sorry.

As I said serveral times, I want a simple knob showing all reserved memory status.
The current debugfs, device tree do not show all those information I want. I think you also know that.
 i.e. late freed pages, splited or merged memblock, address defined at boot time, kernel size, ETC. 

Anyway I think I touched too many points to do this. Let me drop this.

>
>> Thank you
>> Jaewon Kim
>
>-- 
>Sincerely yours,
>Mike.
>
