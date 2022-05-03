Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F69519058
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbiECVlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243006AbiECVlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:41:20 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D71326F4;
        Tue,  3 May 2022 14:37:45 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 82070100007;
        Tue,  3 May 2022 21:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651613864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6LTUzx08avjPkNfHjwYBuKNYze9L5g6GFctRWsa/nw=;
        b=CrEeQ/EqwKWpk9BJkglsusY3giBASc2Op7qbMdTJMrPR4xtHzb9zovtPXWtt/32Suxg809
        t92JhVYoMLrp162it3E9/nkKTP28UJQ41fHMmvah/evnApT/uQ7ed+ZuiNH4eB6ooVqMEr
        85iYWX61U8U+fFpeHxWrjgFq4KKQePyDIot5/eKt6nHkUH+Mc9PyY5Z+xViNymSdz0nFoV
        87rC8kSbaCMShyMqAJ+Dfz+We4Un6KEIzS9/VlwVo8uLxXqVyD0JBAT4yZAYRcHK6JrTkG
        uy8/I4YPZLS34ak6s0fEoSIKJ30B/gyo0T+K30X2jogFAe86LgIEdWDZh1kdUQ==
From:   alexandre.belloni@bootlin.com
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i3c@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: i3c: Convert cdns,i3c-master to DT schema
Date:   Tue,  3 May 2022 23:37:42 +0200
Message-Id: <165161385391.974772.13853911429360180678.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422192224.2594098-1-robh@kernel.org>
References: <20220422192224.2594098-1-robh@kernel.org>
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

On Fri, 22 Apr 2022 14:22:23 -0500, Rob Herring wrote:
> Convert the Cadence I3C master to DT schema format. This fixes a warning
> as it is used in the i3c.yaml example.
> 
> The "nintendo,nunchuk" is not documented by a schema, so change the
> example child device to something which is documented.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: i3c: Convert cdns,i3c-master to DT schema
      commit: 4bd69ecfa672e94334618ef9ec653b2a237cf2d9

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
