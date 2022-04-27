Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9AB5116FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiD0MO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiD0MOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:14:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36681811B1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:11:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g6so3026827ejw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=BcI6cm92uAoy93seyH4hLm4lTU3K0LAkkGc9A5aDw2wXnvmZSL1zUQ7pv38TFurDc8
         cNLeupUJTOMNB/UAKezYACSr0LRRZfIA2rwRmMyUxkA2nS56WZgjS6tQ8qkFaLjp2odE
         OHx0oBwm1dolPAjoAiZG0PzIzcucj9hsYH3iezE5ygohChN5yIoNzlOrZjnNRiuPbTKp
         sQu6GW/9Ne8U3YS3fjga4dFPDIvL7Mlme4ZL0u8XPG8mwOQw63A3Z79UPi/XHjTeUels
         adGgITu+cMwjOcfBBEkV0AgZWaYFJK9ikC3C7PggzHab5Yp5YMQvGmYin5ahZsaRqnPY
         piug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=hErj9XjfGeL0ItBezZJ9DHvZzx9OGet3woZ3RdZ/+5mbZZQ+azEoDecjhxThto49EB
         RYlBHTvTgg8+1uKdVf7z4rlQ4jPWP/uEye0+g7uwCXZNEnMK/AyX5acbsTRn62EqPMfR
         xuopmp/40nTip/0DeREF0KiHPZkYuY/09MYT7ea604e+w5Mhx8GyWzytH4NKJ1xSen9a
         gAC62rF+fXpgLe7AalzR+qxPzopeBjPew3jAweyyTihIKzVSwSx2tK4NpE4tb8srgtmL
         pCNsxhTows9OmLfE6xpu3mpqjsvDAKUp1dv9jjfP94dIIVuaxykSy16KJHXKyzJB1Q/4
         8X1g==
X-Gm-Message-State: AOAM533LqtDETU/CxxXSSKlylZcT04BrrcYv4GgUBl9yIFko0uw8fzfn
        1rJQFRRfzg2No3kdWQXQcTI7gMpahl0vFoJ35nE=
X-Google-Smtp-Source: ABdhPJyXc6w5Ey5Rnh9dQyPAGXRjokm/lj4Z0ScD3ftTVAUyQSnj4ZTJcI4Mzl+pN9ok8dBwHlOl8ZLfrAl87SDbJ6M=
X-Received: by 2002:a17:907:8b05:b0:6f3:cb71:6746 with SMTP id
 sz5-20020a1709078b0500b006f3cb716746mr2146555ejc.274.1651061470447; Wed, 27
 Apr 2022 05:11:10 -0700 (PDT)
MIME-Version: 1.0
Sender: krakauerrandall@gmail.com
Received: by 2002:a05:6408:2406:b0:16c:4005:1ca2 with HTTP; Wed, 27 Apr 2022
 05:11:09 -0700 (PDT)
From:   Mathew Bowles <mathewbowles2021@gmail.com>
Date:   Wed, 27 Apr 2022 12:11:09 +0000
X-Google-Sender-Auth: fiwArKCrMpJTHxMfWLsBKffvVZc
Message-ID: <CAMT0Ay7caZo32MxfdwA5NiehvaY9MCbfSGZvHnn5YfT1S3DchQ@mail.gmail.com>
Subject: Hello, I need your assistance in this very matter
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


