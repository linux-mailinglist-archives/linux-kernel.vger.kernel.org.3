Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C3C4D1C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348019AbiCHPzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiCHPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:55:39 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CC1443E3;
        Tue,  8 Mar 2022 07:54:41 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 157141BF20D;
        Tue,  8 Mar 2022 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646754880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQIGMPI1EYq0Q9kdu5YhozNi+/JkEaWlrg54hIn3HQ8=;
        b=ga43l58sVkxJG1355l/YLiqLwBEIIVIQVvTio7PE3sKcSFlSOQ4X20vmQJOsU1kDGkaIG2
        uH+5JWN6H6JQ2VZP7QAaOzZoc8+bjwfeNHIOjluEZMf3rqX28+HSIti4zUa+4hkFzKMZtE
        uczeJw1JDOtXXi4hDcnMc3AKY/h1yN/8hNRqOyKKOPH7nUS7li9zRNQxr0P6X3q72PA8F8
        Y1gGfBLK/h51pr+rFEn0lngNWFXkSwYXKnE5vQlxY4bBZC0a5DbglIJo+oZdCuH7UvH8/0
        Wa52vGBkBK2TQ+CemtjigWe1H9oOrvy8Qxhvyb896o572OzN7hRXacsDlhHRnw==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        Sergiu Moga <sergiu.moga@microchip.com>,
        nicolas.ferre@microchip.com, a.zummo@towertech.it,
        claudiu.beznea@microchip.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v4 3/4] dt-bindings: rtc: convert at91sam9 bindings to json-schema
Date:   Tue,  8 Mar 2022 16:54:37 +0100
Message-Id: <164675486932.53531.14421337093728185066.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304161159.147784-4-sergiu.moga@microchip.com>
References: <20220304161159.147784-1-sergiu.moga@microchip.com> <20220304161159.147784-4-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 18:11:58 +0200, Sergiu Moga wrote:
> Convert RTC binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> 

Applied, thanks!

[3/4] dt-bindings: rtc: convert at91sam9 bindings to json-schema
      commit: 5b05198b3108d5d287da8c457183855fb91ae4cc

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
