Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0154635EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbhK3OAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:00:04 -0500
Received: from cpanel.siel.si ([46.19.9.99]:41882 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhK3N76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:Subject:Sender:Reply-To:To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U+vPSEQPYX8gP340qKGYbsQniEHCy1ogHkhFwcmSah8=; b=JrnFnS3HbIhAnE+4wthIXa6C3h
        0Ds346gF2nf7MNQW+RIv6jAucGdH0dNIhAdAy7Jp6BihP2vTu1hmnz0pNS31xopD27S+3taHchJgR
        KUBzylj13vemud1wqWILhmxxhGZoVU+kuWDduD0jIB2zWseUw9KpHb84XVidc0mSWDGROecUCDiNi
        11woojoCf2RAPiey3saA5OO5XKhzHj+Tu3KxkT8Vx3JaXaBUgyFl7qovk5vLblC4ukYwl5CTX2i3U
        A7I0hkLrXKRYLnpqJPCHicwzP01L9qQg54ssoxv88PTtsiQsEXK8iiHoDrtno3N0NpES6kUxb7Iwm
        rtH+M+pQ==;
Received: from [89.212.21.243] (port=49996 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1ms3cX-003BJ3-Na; Tue, 30 Nov 2021 14:56:33 +0100
Subject: Re: [PATCH v2 4/4] ARM: dts: imx6: phycore-som: set watchdog timeout
 mode to shutdown
Cc:     support.opensource@diasemi.com, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
References: <20211130134242.3516619-1-andrej.picej@norik.com>
 <20211130134242.3516619-4-andrej.picej@norik.com>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <5808b9fd-8378-c348-0856-bec961b1ace1@norik.com>
Date:   Tue, 30 Nov 2021 14:56:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130134242.3516619-4-andrej.picej@norik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30. 11. 21 14:42, Andrej Picej wrote:
> Enable system restart when the watchdog timeout occurs.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>   arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> index a80aa08a37cb..743343e525cf 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> @@ -111,6 +111,7 @@ da9062_onkey: onkey {
>   		watchdog {
>   			compatible = "dlg,da9062-watchdog";
>   			dlg,use-sw-pm;
> +			dlg,wdt-sd = <1>;
>   		};
>   
>   		regulators {
> 

Changes in v2:
- new patch, enable shutdown mode for phytec-phycore (da9062 user)
