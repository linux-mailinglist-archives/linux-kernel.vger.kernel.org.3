Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985D25B0577
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIGNjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIGNiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:38:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD43A0638
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:38:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v1so1225130plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=WHAPdXUDAFHgnR9EU4rd/PcWyq0br5wcizXxS7w4DJE=;
        b=kQP6HmuyZvHKUR7l20XDspQ8EHIu3UKTI2YuI2j6ZkkABPyaFwCqgzfskbgycTFs5/
         pHoXwDaid1j2jTh4arIQ7c5xBzLTPNxPBjEcgrhm1WS6OXD5e1szZ/Itic6aHD8UkQJp
         ZCtIH4DQc/GGbrr9YMc+76ayzPHC08oPcyuqlTJxPIg6TblKocDHerm6n9UuTy14NzdN
         gCnc4jKR920ys7UEPRE0G2cknXpNPewrAm3nBabVPxh3Q9PoCsekQZsj1rvH+MA+P5K9
         Tm9qU4a5GofMIP3MaUyrl+2mkJKccBeKHqhzYe+nPGDzxTVxxR6w/WVZ96T7Qz9WTb9E
         pKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WHAPdXUDAFHgnR9EU4rd/PcWyq0br5wcizXxS7w4DJE=;
        b=GbJB7qpolmWZpnYaL6vtyHvKuVk1oK3GP4jytNsO1WHRiyWHW0FRrYKubeJC1mr9Vw
         qr3tkuQouRuFFOQ20oCc2wrCRNPlBrrR5N2C450/MESKUGgBY3ivifmv0RK9eE1iP7s0
         X3XyC9mYK8pnVi1XCanFSU37+zO4cmW/6XBQbg5XoZLLbgRScUOI15su05zztRzfxlsQ
         bEpbzeTXbix3jQTY5LE+QDHd2Mkxlkzzza756fG26STWqLqCI+1YveZ0BOrS+IlEQoTu
         dm50v9WdWrSF9w3LC5SHl0mUip/dw0sDFeAuWNglZN/3RRcj2W249x8DjIBwvsBK9A6g
         xhNw==
X-Gm-Message-State: ACgBeo3ac/VmvLC+QNN2/ZFK2C6CQ8uvaV99pEhXTPatxHa4d7R/Bgdt
        4URJVBJedwHVCeclYl6K6MJprF1yZ0lsvoVqcRU=
X-Google-Smtp-Source: AA6agR5kxUxD9Yp+1VQyY0g/NRTYSbnnCa6ViheUxqmnjKAb7YEw1tQHVw16rNiPDF1xvJvO/WpxRjT0psIaCaIZjrA=
X-Received: by 2002:a17:902:b104:b0:172:f66d:6604 with SMTP id
 q4-20020a170902b10400b00172f66d6604mr4016843plr.117.1662557890399; Wed, 07
 Sep 2022 06:38:10 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: madameyao05@gmail.com
Received: by 2002:a17:903:11c6:b0:172:adc5:100f with HTTP; Wed, 7 Sep 2022
 06:38:09 -0700 (PDT)
From:   Kayla Manthey <sgtkalamanthey@gmail.com>
Date:   Wed, 7 Sep 2022 06:38:09 -0700
X-Google-Sender-Auth: BNEYvfINiwr9j67t4oss1R5bwss
Message-ID: <CAP8oFycwqz3RabS7Zd2AkS+qB0obu5icrzsB-tBPwmR_RY_EOw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello did you see my emails? please check and answer me
