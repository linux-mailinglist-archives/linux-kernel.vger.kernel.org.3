Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46E957CE14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiGUOrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGUOq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:46:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498E7E023;
        Thu, 21 Jul 2022 07:46:54 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 40E576601AAA;
        Thu, 21 Jul 2022 15:46:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658414812;
        bh=kmcFUz7HIbwRc4mzs+43jNO9MKiSsiz0lRBnk1Qv66U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WiNlK+jJO9MKGiv1SfmksqZ+t2NkSfC/n7H/UuahJS+QO112TuHxeoqQ91VUziI6g
         +XnGMjb+dg+0JY0khKUXHaCetUgj5vpnJEZd1NkyA+fwsJtFaCMPrZNQ4nPcAlL9cB
         QNLnMJqzu+MgKqmcPmmzXTCW67QUsQExeT6VhatgUaElEbkfj4TfHPzm0HhloTbS2U
         QTPqEEVB8k52ZkOlPvkiOcn5ncTE2EgU8QlO05T8rRsc3WJDtrlQ3ho5CFGic+IDP2
         Jjrafcc00zOpduyx0nTn1s4kXUuUSQYKRRfcChfHCaJxHsCMNy4TR9hI1NL71lTr1d
         Zn4suss5nO8YQ==
Message-ID: <d8b638a2-1f4b-2d9e-ba44-401bf3ce488a@collabora.com>
Date:   Thu, 21 Jul 2022 16:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 8/8] arm64: dts: mediatek: cherry: Enable MT6315
 regulators on SPMI bus
Content-Language: en-US
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721134228.310178-1-angelogioacchino.delregno@collabora.com>
 <20220721134228.310178-9-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220721134228.310178-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/07/22 15:42, AngeloGioacchino Del Regno ha scritto:
> All machines in the Cherry platform use MT6315 over SPMI: add the
> two instances, providing Vbcpu and Vgpu regulators.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Sorry, the Makefile slipped through (did that for a fast dtbs_check).

Sending a V2 soon.

Cheers,
Angelo
