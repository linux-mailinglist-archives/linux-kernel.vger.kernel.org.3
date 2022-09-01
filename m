Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CFB5A9377
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiIAJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiIAJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:44:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4A027DCF;
        Thu,  1 Sep 2022 02:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43603B82555;
        Thu,  1 Sep 2022 09:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AE9C433D6;
        Thu,  1 Sep 2022 09:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662025453;
        bh=oOQnmrGIBRnuz3ZpveSWSRn13K1Gp7xb6uLN1Cbp+U0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T09lsiy1fPYmuUZpQzOsIdZ8SWHYpykdi3LPauc+hyWeMhDh0Lk1TgDtcGe+49ln4
         T/ioHsiR1lDPgDxpBmVcLdoJim+MHmYwfrke6cgJCStWZRSoswLA+PmNxw9s77XsP+
         aSBl5gKv3iIDg56o9f1/TaFJY8sF8JWstawhCrTL4/XoDF2iuXK+rqQ8PuboxTqmx+
         qwuLwuEiK7nAx1jCJbXYfNHo/bK4RVCYWlR4NZ5TF3T/iDidayw6v11ZvThQ25+EKH
         Ccii0lRIMCJbXKj2Dx7y+LpIldJSwh5D6qYBhUCmHLHAUKlD9ubdIzYFBqgv/297Kd
         o4tbRzD8qXORA==
Message-ID: <5dbdcb11-ae9c-e2b5-793b-35fa16a4208b@kernel.org>
Date:   Thu, 1 Sep 2022 12:44:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: Add compatible for MediaTek
 MT8188
Content-Language: en-US
To:     Liju-clr Chen <liju-clr.chen@mediatek.com>,
        Runyang Chen <Runyang.Chen@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220816065330.27570-1-Runyang.Chen@mediatek.com>
 <20220816065330.27570-2-Runyang.Chen@mediatek.com>
 <0b17f336-5c04-e375-ef4a-3804f9702bf8@kernel.org>
 <092345db980b30c577350edc46d88dc3888736d4.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <092345db980b30c577350edc46d88dc3888736d4.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 11:16, Liju-clr Chen wrote:
> Hi Maintainers,
> 
> Gentle ping for this patch.
> It would be appreciated if you could give some suggestions.

Why ping? You got the ack, so what do you need from me?

Best regards,
Krzysztof
