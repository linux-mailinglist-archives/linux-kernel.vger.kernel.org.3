Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF2E4B0906
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiBJJAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:00:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiBJI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:59:57 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752FF1038;
        Thu, 10 Feb 2022 00:59:59 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A78R43010574;
        Thu, 10 Feb 2022 09:59:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=kJhS4sbXo/E16hFG2YvWZRb6ph5i6ukwSDD1RKORhvQ=;
 b=BmZUxt0r0PBrbkc7e4QDqKHdeyQDvtlsvHqNUpYK5Qz8xzxnPlk9GwKGtZr/04kvOrin
 pY6YZkn03yQ3KJ5JIOtUEHIcxncTwj7txeeykINmlvEXhRc0/zv1OY+YzntwLpHjqGqn
 jLOEzUf8dPmJ8dgdYDBjOOCctTM+3bJIgwD4yZ6ECj9mEYVlHc9MEbMkGzNYGiutlk7M
 CDFB4xr3+jzWv4WrdFHmO1iy3LwhvFfr71anAgSfotae1mPD5bpUjswfif9GOb+PTzsy
 CiFui6Ixeg1xiiEMmgxXYv5+njzEUKeRv/OzYuKfiXbnWZXl15ADNkPt+KNfuUGmQEcN yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4x268nj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 09:59:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 607F310002A;
        Thu, 10 Feb 2022 09:59:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5897221513B;
        Thu, 10 Feb 2022 09:59:42 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 10 Feb
 2022 09:59:41 +0100
Message-ID: <014f2de2-6b6c-c60e-1f5d-98a74649b8e7@foss.st.com>
Date:   Thu, 10 Feb 2022 09:59:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/12] ARM: dts: sti: various DT fixes to avoid warnings
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, <patrice.chotard@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211202075105.195664-1-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_03,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

Pleased resubmit this series by squashing PATCH 1/4/5/6/7 together, the 
compilation is broken and doesn't allow bisection.

The same with patches 9/11/12.

Thanks
Patrice

On 12/2/21 08:50, Alain Volmat wrote:
> A first serie to correct a large amount of DT warnings seen when
> building with the W=1 option and mainly due to having several time
> the same reg property (clock) or having unnecessary reg value.
> 
> The first 3 patches related to clocks require that recent serie [1] of
> clock drivers improvements be first merged.
> 
> [1] https://lore.kernel.org/linux-clk/20211202072850.194314-1-avolmat@me.com/T/#t
> 
> Alain Volmat (12):
>   ARM: dts: sti: ensure unique unit-address in stih407-clock
>   ARM: dts: sti: ensure unique unit-address in stih410-clock
>   ARM: dts: sti: ensure unique unit-address in stih418-clock
>   ARM: dts: sti: move some nodes out of the soc section in
>     stih407-family.dtsi
>   ARM: dts: sti: update stih410-b2260 following stih407-family DT update
>   ARM: dts: sti: update stih418-b2199 following stih407-family DT update
>   ARM: dts: sti: update stihxxx-b2120 following stih407-family DT update
>   ARM: dts: sti: remove delta node from stih410.dtsi
>   ARM: dts: sti: move usb picophy nodes out of soc in stih410.dtsi
>   ARM: dts: sti: move usb picophy nodes out of soc in stih418.dtsi
>   ARM: dts: sti: move usb picophy nodes in stih410-b2120.dts
>   ARM: dts: sti: move usb picophy nodes in stih410-b2260.dts
> 
>  arch/arm/boot/dts/stih407-clock.dtsi  | 101 +++++-----
>  arch/arm/boot/dts/stih407-family.dtsi | 262 +++++++++++++-------------
>  arch/arm/boot/dts/stih410-b2120.dts   |  16 +-
>  arch/arm/boot/dts/stih410-b2260.dts   |  30 +--
>  arch/arm/boot/dts/stih410-clock.dtsi  | 100 +++++-----
>  arch/arm/boot/dts/stih410.dtsi        |  52 ++---
>  arch/arm/boot/dts/stih418-b2199.dts   |  22 +--
>  arch/arm/boot/dts/stih418-clock.dtsi  | 101 +++++-----
>  arch/arm/boot/dts/stih418.dtsi        |  38 ++--
>  arch/arm/boot/dts/stihxxx-b2120.dtsi  |  22 +--
>  10 files changed, 351 insertions(+), 393 deletions(-)
> 
