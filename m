Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1855FA01
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiF2IHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiF2IHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:07:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85213B574;
        Wed, 29 Jun 2022 01:07:36 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79B8D66015AE;
        Wed, 29 Jun 2022 09:07:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656490055;
        bh=2x7JJI7Gpw9v/avN+IvIawiJAZWgc780v4UFmC7WN1M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KIpXSyrfyDOlg0nVmlbqYjC3ymVb5Sap7cwjq6Udb6iHNuvrq9iIMOa/2ca4p4V/5
         P/kJAMUJa/ciPMEkWhzKE30x2Zz9KoSJXwZFAa9Aq6AsRxgQZQpsmgNT2zKWSAObba
         vJMVJVOh+/82uJjnZ1HBPPjeNIcBIR7X5qXvMCq1GXYCvOOdFgcAYuPRFnxN7oVa0f
         yVQiDkg+yDZ3JPMRaB3cnTWx47bg8fBBB2zx9aMQijBlEXSK9iiEGRx/Emi09q2BGT
         BUXkBXOxHvhjq0d4HQoopaqO0/2SXdiKbvCSZ4DcIvUnXlkJLboMNEEKkg4HQYXGWF
         mvqB6VSuVbclg==
Message-ID: <4329eb0e-eb4b-f0d2-358f-e1d15a9c49de@collabora.com>
Date:   Wed, 29 Jun 2022 10:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] usb: gadget: f_uac1: add interface association
 descriptor
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Julian Scheel <julian@jusst.de>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Yunhao Tian <t123yh.xyz@gmail.com>,
        xin lin <xin.lin@mediatek.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220629021304.21725-1-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220629021304.21725-1-chunfeng.yun@mediatek.com>
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

Il 29/06/22 04:13, Chunfeng Yun ha scritto:
> From: xin lin <xin.lin@mediatek.com>
> 
> When we want to use a composite device that supports UVC, UAC1 and
> ADB at the same time, encounter that UAC1 can't work when connected
> to windows 10 system.
> from the online documents of microsoft, "overview of enumeration of
> interface collections on usb composite devices", it recommends that
> vendors use IADs (interface association descriptor) to define
> interface collections.
> After addding IAD, we can fix the issue.
> 
> Signed-off-by: xin lin <xin.lin@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

