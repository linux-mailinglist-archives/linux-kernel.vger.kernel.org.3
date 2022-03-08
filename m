Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01014D1C5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348021AbiCHPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347991AbiCHPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:55:41 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A9457A1;
        Tue,  8 Mar 2022 07:54:43 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C492524000F;
        Tue,  8 Mar 2022 15:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646754881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkzCxRFWy2RXKvSt8FmblLtVxf0XOpI9XeLlJAsGoq4=;
        b=iNmKWFkri2qDn31ceQ34o+J2bcPtXtG5if5uxGvovGkh5qzfRWmmwdHO7P6kyRIQmLkOFv
        zcf/q3UAiELNzSEvurmY9S7/RKmE+W3gPli4wYJq3l8zIxqkzsjRhqz54UvjKlW84depvi
        irHDQ0y7V+S/iZvdrlKFXeq1Yorgr6s/THGGUbWptNWFDsDo/oYRnPL2kMePcgVXazquOW
        ojUdCV60kMEZfIz/CShXO0seatfO4QxB/2WySmKUnpCbn/drf0s+U7NMLq+47hmDgFX2cT
        cQYl298TB/HQZJPbHriY8vKr/q1L/vz2pNT7LOmzbXuaV3oO265rwWBoBPbh5A==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        Sergiu Moga <sergiu.moga@microchip.com>,
        nicolas.ferre@microchip.com, a.zummo@towertech.it,
        claudiu.beznea@microchip.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v4 4/4] dt-bindings: rtc: at91: Add SAMA7G5 compatible strings list
Date:   Tue,  8 Mar 2022 16:54:38 +0100
Message-Id: <164675486933.53531.3497287837886155272.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304161159.147784-5-sergiu.moga@microchip.com>
References: <20220304161159.147784-1-sergiu.moga@microchip.com> <20220304161159.147784-5-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 18:11:59 +0200, Sergiu Moga wrote:
> Add compatible strings list for SAMA7G5.
> 
> 

Applied, thanks!

[4/4] dt-bindings: rtc: at91: Add SAMA7G5 compatible strings list
      commit: 64a6497017843fc23d4c18542bdd4cfcca7878c9

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
