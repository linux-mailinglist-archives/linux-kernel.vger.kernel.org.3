Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B4D4737C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbhLMWnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:43:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43464 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243685AbhLMWnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:43:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 7E26C1F44304
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639435424; bh=UEBxljg7U0AjxP8YVVrv1TQKitx1bpMVVjCQIvNZxmM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gtp42DPr62P1xEgyR9Ua5atRu227T9uo7AU0GOjOCcpdQT76gXktGHcEoHfDVKpSm
         G9sbIRXCepQNryY6CwJygV68qXn+qbLbDs2F0RIUrvbim3xazRDRoBTx+0fEfk3JfQ
         5MMwP3aNhLdNnQTZJymmDEt+r5UKlav1XDpH0FwwQWWwkBPNL5syEkmDr3nNSsFc0l
         x79S1m3gYVR9BXAiYlzobKsupboLT4i+G51pLLa901grhOEhxA9DflmEb7EiuhZC6/
         seQl9WwNKCE589LGMiy59wHts1Ulv9mQVyVx0CXwnS5yA8wJUrILquRIEExGCUy92N
         vh51hArjODXrA==
Subject: Re: [PATCH 0/4] fsl-asoc-card: Add optional dt property for setting
 mclk-id
To:     Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        bcousson@baylibre.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com,
        tony@atomide.com
References: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
 <YbeukcwXQueEquJZ@robh.at.kernel.org>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Message-ID: <f35f34bc-e850-40a8-7d5e-3b783aeeaac8@collabora.com>
Date:   Mon, 13 Dec 2021 19:43:32 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YbeukcwXQueEquJZ@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.

On 12/13/21 5:35 PM, Rob Herring wrote:
> On Fri, Dec 03, 2021 at 10:49:26AM -0300, Ariel D'Alessandro wrote:
>> This is a follow up of patchset:
>>
>>     [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx
> 
> Link?

Link to the datasheet?

http://www.ti.com/lit/ds/symlink/tlv320aic3100.pdf

> 
>> Sound cards may allow using different main clock inputs. In the generic
>> fsl-asoc-card driver, these values are hardcoded for each specific card
>> configuration.
>>
>> Let's make it more flexible, allowing setting mclk-id from the
>> device-tree node.
>>
>> Ariel D'Alessandro (4):
>>   dt-bindings: sound: Rename tlv320aic31xx-micbias as tlv320aic31xx
>>   dt-bindings: tlv320aic31xx: Define PLL clock inputs
>>   ASoC: fsl-asoc-card: Add optional dt property for setting mclk-id
> 
> 'mclk-id' is not documented.
> 
>>   ASoC: fsl-asoc-card: Remove BCLK default value for tlv320aic31xx card
>>
>>  .../devicetree/bindings/sound/fsl-asoc-card.txt    |  1 +
>>  .../devicetree/bindings/sound/tlv320aic31xx.txt    |  2 +-
>>  arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
>>  include/dt-bindings/sound/tlv320aic31xx-micbias.h  |  9 ---------
>>  include/dt-bindings/sound/tlv320aic31xx.h          | 14 ++++++++++++++
>>  sound/soc/codecs/tlv320aic31xx.c                   |  2 +-
>>  sound/soc/fsl/fsl-asoc-card.c                      |  7 ++++++-
>>  7 files changed, 24 insertions(+), 13 deletions(-)
>>  delete mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
>>  create mode 100644 include/dt-bindings/sound/tlv320aic31xx.h
>>
>> -- 
>> 2.30.2

Regards,
Ariel
