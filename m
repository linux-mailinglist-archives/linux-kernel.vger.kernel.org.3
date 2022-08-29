Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378415A4626
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiH2Jd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiH2Jd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:33:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6065A806
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:33:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5BA496601DB2;
        Mon, 29 Aug 2022 10:33:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661765603;
        bh=TeeiT3sOJD7ti95kUOVN+hHl62A13KKzEUX5gr7qxoY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bYFXlHfCvVW3d8M5OyGw5U34C40yYrQTineqrlNQhResTqgK8x1QOy66hNAkKka+I
         Ce4pEa8FljcExBpHQlu0UzWag8PIgelGaquxFPg+ubuTAMptCH2oQYDnv2gPWI9ukt
         qxDk+jlDmCaIIG8Glg4lWUJfB6oXSYl/un/ZM6vNRp76veV6Bg5ElmQ81PoUP9V97W
         w8+tQt6OjwFY0VGjaegF6b1yKIp64dxfp3yNHRKtzyIOQORh3/VmZIQbGg8DY02MT8
         dQxXc6cTH5aUc7hpQnKyqEbsDUaWLWlUZxQ1f6gQ/WrpnJr8ieMIQA2O0J+5cwcJCd
         JB8bSI7w73KyA==
Message-ID: <5ef83611-1649-c86b-abd8-dff617993580@collabora.com>
Date:   Mon, 29 Aug 2022 11:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] soc: mediatek: mtk-svs: Use bitfield access macros
 where possible
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
 <20220726141653.177948-7-angelogioacchino.delregno@collabora.com>
 <fa5f9bc8-f087-02c6-dd31-efa33244bf1b@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <fa5f9bc8-f087-02c6-dd31-efa33244bf1b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/08/22 15:29, Matthias Brugger ha scritto:
> 
> 
> On 26/07/2022 16:16, AngeloGioacchino Del Regno wrote:
>> In order to enhance readability and safety during registers setup
>> and value retrieval, redefine a few register related macros and
>> convert all open-coded instances of bitfield setting/retrieval
>> to use the FIELD_PREP() and FIELD_GET() macros.
>> While at it, some macros were renamed to further enhance readability.
>>
>> This commit brings no functional changes.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Does not apply, would you mind to resend together with 1/6? Thanks!
> 

Hey Matthias,

thanks for picking the ones that applied cleanly in the meanwhile.

I'll rebase this and 1/6 as soon as I can!

Cheers,
Angelo
