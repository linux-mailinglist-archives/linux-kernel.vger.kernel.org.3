Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA8543B67
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiFHSWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiFHSWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:22:18 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21255195798
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:22:17 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w16so19232594oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4DjCe6UybPdUfZgMKb4bWM6hbvRKrmaZNL7MTdhYWrE=;
        b=heLpgWqP3qp/dNYcpDicBIbC9YAufp9awlalKjjyyv1Pqdi3gsECgKmgnQiO6VsIv9
         p2b2sI+u2JIhEv3kXXitDB4eQHdyFwVvM4sGwOz+xi8sm1vQQcyW0rn86eIxFhM871p2
         1zYO2eStXll/YWulF3p3HdW1rz/JOHWry1wTxeO5b6hX/KbXtAB9Znkyy7VYGmgZs9mF
         RX563uwEZRjWonTvzVYev/XwdbGu1V6+TJkVZlBwc+jMW4AXzbKQRpg0WGUDzcpOcaun
         3St/b5lN0neEtW3ZDjs6fSYyTFL0VYln/JH4CgjENsKxbrLKGQ/yREzxbJ7sEZVui+hb
         IcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=4DjCe6UybPdUfZgMKb4bWM6hbvRKrmaZNL7MTdhYWrE=;
        b=vkpHImiwzIGuypRWL5uqxyrdAayBMvJCSvI3vZUHYzaqoexZaN6+/rrOxtEKMvp8rK
         V2ylrV+pauFDD7hjoe8VVEPwXrlcv46pgCi4Hm0dv7RTCl1tGhyeTbg30XwTQUnfTieO
         hFteQcsHvNc69RtDqDkruH6lNLsxnSOBtf7FOlIGY/7ymDwzlrCfEmSaflOiR8M/eA+/
         N58MlCVkkUNRh9sSqnfrFxE4DyPSyt6WRsouuzSQHSnYQHORa/DRXxbdtMA/wTH7X6VV
         tr/58HYYZpJx4DuKdmBlIJHu+Ny1cWcJKrUTL70MI4wqgd50bUDWnPEncHXhHr1QgRED
         35Tg==
X-Gm-Message-State: AOAM5330AUPAiODueLdT8jYqWxGmPmwuic/vTCjePxqAPGi3c3GEs6V/
        MxzFXTG0lmLq3RWek420K8RKmyq9lmPof/AuHjo=
X-Google-Smtp-Source: ABdhPJywqIMeyMedZjzoXtBH6Mt6sI6lBZHQS9LHiyMP462XkzzeK5+Cs+8LbQ6/JvXuo7fV5GpFTZqcarLV+uuCzFE=
X-Received: by 2002:a05:6808:2125:b0:32b:1ba0:8b05 with SMTP id
 r37-20020a056808212500b0032b1ba08b05mr3229144oiw.20.1654712536455; Wed, 08
 Jun 2022 11:22:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:1b8e:0:0:0:0 with HTTP; Wed, 8 Jun 2022 11:22:16
 -0700 (PDT)
Reply-To: rl715537@gmail.com
From:   Rebecca Lawrence <agoudadjamiou90@gmail.com>
Date:   Wed, 8 Jun 2022 18:22:16 +0000
Message-ID: <CAKNxr8Ps4N-yA+vwx=f+DeQe5hpMZfe5a5KKEDng+d8_tqnecQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,MIXED_ES,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWhvaiB6bGF0bywNCkptZW51amkgc2UgUmViZWNjYSwganNlbSB6ZSBTcG9qZW7DvWNoIHN0w6F0
xa8gYSB2b2plbnNrw6Egxb5lbmEsIGt0ZXLDoSBzZQ0KamXFoXTEmyBuaWtkeSBuZXByb3ZkYWxh
IGJleiBkxJt0w60uIE5hcmF6aWwganNlbSBuYSB0dsWvaiBwcm9maWwgYSBvc29ibsSbDQptxJsg
emF1amFsbyBiw710IHR2w71tIHDFmcOtdGVsZW0uIFYgcMWZw61wYWTEmyBkxa92xJtybsO9Y2gg
esOhbGXFvml0b3N0w60gbcSbDQpwcm9zw61tIGtvbnRha3R1anRlIHpwxJt0IHByb3N0xZllZG5p
Y3R2w61tIG3DqWhvIHNvdWtyb23DqWhvIGUtbWFpbHUNCnJsNzE1NTM3QGdtYWlsLmNvbSwgYWJ5
Y2ggdsOhbSB1bW/Fvm5pbCBwb3PDrWxhdCBzdsOpIG9icsOhemt5IGEgcG9za3l0bm91dA0KdsOh
bSBvIG1uxJsgZGFsxaHDrSBwb2Ryb2Jub3N0aS4gRG91ZsOhbSDFvmUgdMSbIGJyenkgdXNsecWh
w61tLg0KcG96ZHJhdnkNClJlYmVjY2EuDQo=
