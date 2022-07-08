Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D033956B988
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbiGHMUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiGHMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:20:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DBA19A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:20:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r6so15226955edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=VG5j2/TR4kJtD+GePehT1rxlcBn63S4g8JpAj8tuOa81hHxkNn4eeD9TxjwzxjPQKI
         c9x3sPFwXub2ZfInAi2nc6h4YpbqUQJjVQ9ItkR3MrgJI6JBDY8LOQSyUK3LFoQWzZm+
         ADh6osYt9tiyY95fHAjMOCsOI3zx/FDmG6BR/ggpqPzR9gUoxGZyvHCeMQfJNVd3SlU0
         M40rYA2DEdRv2vYZekenzYrk7y/FkIs4rHerLYi/VydTq8eeaFRy3X6GKshMVY5K7xeI
         FUfK0fjXyBzqUFH6BozsY876YY/AVy5QNXtgGohOnQo+G68e27KnlSFfaKW90wJvznib
         j7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=dzTTVtktdZsI2qSQ6MHwbWzjFTL73mi2eacK9/PTCDAlOMsqWg//NIbaJYO1J/Fkfw
         v21lY0wWm0KE1OerH8UunF5lBnL3KAcmZOSr+v8Knw7UJy1HlauVGwoLBQ4NjRkkJQCH
         DtzjegwV2/Qxv6aKhoQBzFbGz8jBPKhzLFV+5LDmHxWy/DSkKsp7OxMy7443eBUbQwo7
         SFFoaISwx2a5JYhmVuGdAEgxcUkYLtqhmM7Vd/ttOX87xPTw67m+MaBNGAOZW2hTmU43
         a9Won6B0Yyjs0c832Ty44UrYHUZEyzrTleaJh+75CAYwqls6Id+RsTrWrPYB+0VZRJk1
         Lflg==
X-Gm-Message-State: AJIora/LigJ/zlVGTvMbn8qRqxPOVDzMXp4ZE4AUaZN3czWYJ2C6+uyL
        5wUNMiqVD1xbK4V1mGHQCXEYN4fqyNEleCfQSFI=
X-Google-Smtp-Source: AGRyM1vEeMb+G1xdbi81D7WKJss5XAa7zzoKLJIZIIwCVOwP3d8L4UQ4UR0/AtSi2sHPX56zWTNzd2UyyUKp7sbGpS0=
X-Received: by 2002:a05:6402:492:b0:437:4b50:d616 with SMTP id
 k18-20020a056402049200b004374b50d616mr4262651edv.43.1657282799918; Fri, 08
 Jul 2022 05:19:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:608f:0:0:0:0 with HTTP; Fri, 8 Jul 2022 05:19:59
 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   blewoussi agbeko <blewoussiagbeko33@gmail.com>
Date:   Fri, 8 Jul 2022 13:19:59 +0100
Message-ID: <CABUD+3aN70ZfAYPC8HHtd_2GYf9JTYOh4smN346RMCkXGwe05A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
