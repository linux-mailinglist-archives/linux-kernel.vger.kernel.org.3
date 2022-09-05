Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881285ACD1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiIEHs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiIEHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:48:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11A399F7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:48:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73DCC6601E74;
        Mon,  5 Sep 2022 08:48:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662364134;
        bh=ifeP0r3pcu7K42tQxkfGTWseJu3C0X8ZYf3G/UE662w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lO/v/0YooHjyVD5h+o5PJdm2yp6Gza2tJURV14lNDSVKyH5yV9rlkO68HKveNAXv0
         yjk7ni1KJf3JkfvCQGe6O0m30yZca+d8Q81v6XpeJlQ0QmWeAOVloK6ZrNplz1ja6n
         T+BwDp9/Vbpst9fwYnWpbn3+51obCq/SLsZAula4IMmnlGrRAYmZKQYvQfzZhcHOZH
         SrkwF2WKu7miuFK9QnX/KFJtUxPNZR7mjgOVae9fkpZmnYaJLDzrf2Um4CfvlNvWLy
         hLQg7WuBZpo76KNB2bBMEiA/tvgTbBsrfFdK/P4mNoffi3zAl02C3UMxTECvJiHNIT
         pX22l/bHp63JA==
Message-ID: <d1815aba-e11b-9014-e1d1-59425c4358df@collabora.com>
Date:   Mon, 5 Sep 2022 09:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ASoC: SOF: Introduce function sof_of_machine_select
To:     Chunxu Li <chunxu.li@mediatek.com>, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com
Cc:     matthias.bgg@gmail.com, yc.hung@mediatek.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com
References: <20220903032151.13664-1-chunxu.li@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220903032151.13664-1-chunxu.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/09/22 05:21, Chunxu Li ha scritto:
>  From current design in sof_machine_check the SOF can only support
> ACPI type machine.
> 
> In sof_machine_check if there is no ACPI machine exist, the function
> will return -ENODEV directly, that's we don't expected if we do not
> base on ACPI machine.
> 
> So we add a new function named sof_of_machine_select that we can pass
> sof_machine_check and obtain info required by snd_sof_new_platform_drv.
> 
> Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


