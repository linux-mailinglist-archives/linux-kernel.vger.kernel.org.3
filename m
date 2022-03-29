Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CC34EA9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiC2Iwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiC2Iwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:52:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451374D9E8;
        Tue, 29 Mar 2022 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648543850; x=1680079850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0r3zs2np5g1OGyfR5AfBJmzryAoR1xJqsqcoDejQqWU=;
  b=yk4zhCNfipUX7eRQzl/UWFsl14TkWgV2nFyQ/JLuu6mnldU1Qx+kirAp
   HLM8rwpAp6PWXxOKFxbhKl6Hs1XrckSBku5ZWXzHO2Sflw/U1Kb8vOv46
   VbynjfzxLp+Owgf/x9Qk2FSbxb6ySmn/gEjlF83HAidCgv37I+YYfZWFx
   8arXK4lidSDelocVshQlRpnyUWoHlbgM5kxJRuCXuYVsKfwU0QRAhpUh0
   aRKwX98fKthGl/CZztXDOkMfjqYL/wbG0Imu2rced0IOEw4agUjJ5KCf9
   T+XnH6gB5ZmpDt2G31geY8en+lD7dZNIcvvVGPavFtdgmQeFSJltAH1tB
   A==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643698800"; 
   d="scan'208";a="158497460"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2022 01:50:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 29 Mar 2022 01:50:48 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 29 Mar 2022 01:50:41 -0700
Message-ID: <4ff4f171-c5f8-87af-aad1-5e7686292288@microchip.com>
Date:   Tue, 29 Mar 2022 10:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Language: en-US
To:     Daniel Palmer <daniel@0x0f.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Santiago Esteban <Santiago.Esteban@microchip.com>,
        Cristian Birsan <Cristian.Birsan@microchip.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-actions@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <linux-omap@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@axis.com>, <linux-aspeed@lists.ozlabs.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <kernel@dh-electronics.com>, <linux-mediatek@lists.infradead.org>,
        <openbmc@lists.ozlabs.org>, <linux-tegra@vger.kernel.org>,
        <linux-oxnas@groups.io>, <linux-arm-msm@vger.kernel.org>,
        <linux-unisoc@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ansuel, All,

On 28/03/2022 at 10:55, Daniel Palmer wrote:
> Hi Ansuel
> 
> On Mon, 28 Mar 2022 at 09:09, Ansuel Smith <ansuelsmth@gmail.com> wrote:
>>
>> Hi,
>> as the title say, the intention of this ""series"" is to finally categorize
>> the ARM dts directory in subdirectory for each oem.
> 
> While I agree with this change and think it's for the good (browsing
> the ARM dts directory at the moment is frustrating..) I think
> buildroot and others need to be told about this as it'll potentially
> break their kernel build scripting for ARM and probably messes up the
> configs they have for existing boards.

This aspect mustn't be underestimated and I anticipate lots of issues 
during a long time on this particular topic of "build systems".

Another aspect is CI and public or private testing farms we all have 
running.

These aspects always refrained me to change anything in the naming 
scheme of our DT files, but if we go in this direction, we must really 
be prepared and I'm still not convince it's worth it...


If this has to happen, I would also like to queue some file name changes 
to do all modifications in one go in order to lower the annoyance level 
of those who would need to adapt to those changes.

BTW, is there a common scheme for dts/dtsi file naming? Is it more 
enforced in one way or another for arm64 in a sense that I can take some 
norm as an example?

[..]

Best regards,
   Nicolas



-- 
Nicolas Ferre
