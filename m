Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3C506BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347512AbiDSMN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349864AbiDSMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:12:18 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0636150;
        Tue, 19 Apr 2022 05:07:00 -0700 (PDT)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DBDDD25B;
        Tue, 19 Apr 2022 14:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650370018;
        bh=0Xeowu0RhaZtA8PPIHf6S0q1sgEvMK0EbPNkXmVElWU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QD4vRkbtdEt/jjwbeO5ht1/C2/Ay4r7c43mTcue5NwcNvy/ZCkIqsSWtGB2es2ScJ
         F6CXO/c1XKEcqcsHT4DxDsRJ9e/GgFFw10M+JTRAiGlG6QEQP2bNWV0GR8vvGTVMkI
         1AtdzPj6b2AfYmbhkEJ83H1Vi0wtF56c9pbxCrdc=
Message-ID: <9e848e84-a31f-98ec-ed6b-c1dce022723b@ideasonboard.com>
Date:   Tue, 19 Apr 2022 15:06:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/2] Update register & interrupt info in am65x DSS
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>
References: <20220419070302.16502-1-a-bhatia1@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220419070302.16502-1-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 10:03, Aradhya Bhatia wrote:
> The Display SubSystem IP on the ti's am65x soc has an additional
> register space "common1" and services a maximum of 2 interrupts.
> 
> The first patch in the series adds the required updates to the yaml
> file. The second patch then reflects the yaml updates in the DSS DT
> node of am65x soc.
> 
> Aradhya Bhatia (2):
>    dt-bindings: display: ti,am65x-dss: Add missing register & interrupt
>    arm64: dts: ti: k3-am65: Add missing register & interrupt in DSS node
> 
>   .../devicetree/bindings/display/ti/ti,am65x-dss.yaml   | 10 +++++++---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi               |  6 ++++--
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

How are you planning to use the common1 area?

  Tomi
