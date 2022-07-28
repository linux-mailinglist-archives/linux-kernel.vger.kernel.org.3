Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10883583E51
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbiG1MHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbiG1MHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:07:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584C858B6D;
        Thu, 28 Jul 2022 05:07:41 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7F2EE56D;
        Thu, 28 Jul 2022 14:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1659010059;
        bh=NYs1CegJfOdzTMrWzKcwsScJu3f3bNBSqgfmlYee5Ak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j1bGehUMRAMkTOMtefUeFkONS1rJvY3Q2Xxaq0dKdqYuxQftsyJ6NExvMVJ6HvPtF
         tKvYMJGKVWbT8/2NOzCD4B3Aa2hLI5rWynCcCCP5g7oCoocWKK5fm3OFDV7pIk1i6g
         4sTnfVgLdjnIVUvrq/p8qDCbyk7HKQr4lrKNPBc0=
Message-ID: <ca2c4f5b-7300-60cd-9667-f6441dec969f@ideasonboard.com>
Date:   Thu, 28 Jul 2022 15:07:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/8] drm/tidss: Add support for DSS port properties
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-4-a-bhatia1@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220719080845.22122-4-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 11:08, Aradhya Bhatia wrote:
> Add support to enable and read the dss port properties.
> 
> The "ti,oldi-mode" property indicates the tidss driver how many OLDI
> TXes are enabled as well as which mode do they need to be connected in.
> 
> The "ti,rgb565_to_888" is a special property that forces the DSS to
> output 16bit RGB565 data to a 24bit RGB888 bridge. This property can be
> used when the bridge does not explicity support RGB565.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>

I think it would be good if you would split the patches that contain 
both OLDI and rgb565 changes, and arrange the series so that you first 
have patches that add the rgb565 (dt and driver), and after that, the 
OLDI changes.

They are fully separate things, and makes understanding the changes a 
bit easier.

  Tomi
