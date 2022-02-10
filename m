Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A714B0E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbiBJNak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:30:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiBJNaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:30:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0186EBA9;
        Thu, 10 Feb 2022 05:30:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 6B6971F46453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644499839;
        bh=2zdjWTY9pmqeyCcaii9xQhF6IAogRoT+OvBfJoZCOww=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hl6mZBaKFGEzPDcKwFhyRNX6jGsaW3U74lS0m6ksQUUh012PTBl+wtIFzcT9Q2Yo5
         Iyvxt7vCgsMXAbWBnc/NXBwSrKxVM2JHhKM7uUlg+sXJR+nyq4HfeVIAuYvRK4WBFK
         x0gaNSYzlo/zu1xD5QCPa+G2TXDhenaa0Nbo84hwqwyzk+KQjrC4OmamL8+y5FfNCy
         +tKaKafk2d19ukbrtFANgyEYiKQhcFnNcYEakGqQ3zRW3om+j6CsM5AKzmbc+4fOww
         ER8ivV+wQHXgliJNtji7hEPkrbn5aKGJydr+xLco3SzdMG5Oh6Jz73mlwFUd+eoyx7
         9Ks5r+BMz4T3g==
Message-ID: <2cfa6083-8f9a-2355-d99b-4ac1a8b00965@collabora.com>
Date:   Thu, 10 Feb 2022 10:30:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] ASoC: bindings: fsl-asoc-card: Add compatible for
 tlv320aic31xx codec
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        festevam@gmail.com, krzysztof.kozlowski@canonical.com,
        lgirdwood@gmail.com, michael@amarulasolutions.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
References: <20220207164946.558862-1-packagers@lists.apertis.org>
 <YgUSEvMGMoSQYy5v@sirena.org.uk>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <YgUSEvMGMoSQYy5v@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2/10/22 10:24, Mark Brown wrote:
> On Mon, Feb 07, 2022 at 01:49:45PM -0300, Apertis package maintainers wrote:
>> From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>>
>> Commit 8c9b9cfb7724 ("ASoC: fsl-asoc-card: Support
>> fsl,imx-audio-tlv320aic31xx codec")' added support for tlv320aic31xx
>> codec to fsl-asoc-card, but missed the related device-tree compatible
>> string documentation. Fix this.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> ---
> 
> This has a signoff from Ariel but the mail comes from something called
> "Apertis package maintainers" and I really can't tell if there's a good
> signoff chain here, please see Documentation/process/submitting-patches.rst
> for details on what this is and why it's important.  The submission
> really needs to come from an actual person who's providing a signoff.

Ugh (:hard-facepalm:) totally a misconfiguration on my mail client. Will 
resubmit right away. Sorry for not noticing it when I sent the patchset.

Thanks,
Ariel
