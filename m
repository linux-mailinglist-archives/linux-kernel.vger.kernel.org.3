Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E35F4F9420
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiDHLdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiDHLch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:32:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8501D1680BF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:30:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y32so14529540lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ar7J0q5TBvj4JiOsJkLg5yRCzguY7N41/mnGFGg4rJE=;
        b=eEKzJRxNhFZrMR0qwHEHFCREyEAHhZnaZPASO8wF3vQSm1ytinODeXgygvpLe5DRdM
         nSYdFAUlq3xoN0RSE/q1K9N9Ks2SAzvMlrf3gkBIKN2onaX/rsWIWPwLyqrdI8neN1O+
         +P+T/CW3Swg72ngAco5FZjZzvXoUNBnjaVn9f3mjmgF1XIMsWfudrZsgOobDyQoMvvgb
         q19cc3ZHJocjHGG0lPpmeHnf0xlcZTkdkWnfmMnbT3eWW4zSsTNiei3yfyH4RF9Tc5Uc
         ta3CPbRzW/sX414GBFPgxN+YEwQoh29Rvt7onOYi6A/hWU1Q/oA58+KEjSYMFRP1Bp+9
         mcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ar7J0q5TBvj4JiOsJkLg5yRCzguY7N41/mnGFGg4rJE=;
        b=BNax/pZVQ2TQS3ABQ867RNQNaHK+VXiiG3jtcFFDlAE9UKudlFcGqTd9Y2xQp8SCtt
         jGzDCo5alyrVbMi3PPCcUUqA54a+4vfFUEZhHn1hSs2aY116CcWyno65pf312/p27PaL
         JHeYUWlG2wTsF1vsNSrGTJTeqgOUdQDdhEvNaT17PNx7CT89j5t+/6WerzNQw6Caib55
         vU+ZiU2Dr1h4b5LSdT0Db10y340So2/xMkPYoBP7fJ5OVKaViyjSYSWn5CG7aTsCjxRA
         X9/Wxr+3TqCfciE3V/N2AWfrRcIOarhPjXHEk684a5zD2+nvishHZywpn49hlJLfvg8H
         GMNw==
X-Gm-Message-State: AOAM532a7TWrAbuWb3UZuJYcFJ7EmwiCjolZXvsddhpGOfg0FAQOI8m/
        envrIhhzrN3hRFMlXOgBWTHbI8ptr2YEoWY1RtvKLwjGW9A=
X-Google-Smtp-Source: ABdhPJx5gtqwM/usOrF6es6sbRtsd5GTw3m6UsVmBwzpJEkvhjz8ukvyGpqC/3WbJtOrp25OzpXuDfpnptbe+PKQeow=
X-Received: by 2002:a05:6512:2608:b0:448:35c4:bc9f with SMTP id
 bt8-20020a056512260800b0044835c4bc9fmr11780657lfb.666.1649417431745; Fri, 08
 Apr 2022 04:30:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:244d:b0:1a0:2f2f:38be with HTTP; Fri, 8 Apr 2022
 04:30:31 -0700 (PDT)
Reply-To: philandcryto@gmail.com
From:   philand cryto <philandcryto@gmail.com>
Date:   Fri, 8 Apr 2022 11:30:31 +0000
Message-ID: <CAF6++AtKCLxQNw7HuThmO8AG8K0KO7AU3676y+6PP101Xx7gNw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0J3QtSDQstC+0LfRgNCw0LbQsNC10YLQtSwg0LXRgdC70Lgg0Y8g0L/QvtC30L3QsNC60L7QvNC7
0Y4g0LLQsNGBINGBINC90LDQtNC10LbQvdC+0Lkg0Lgg0L/RgNC40LHRi9C70YzQvdC+0LkNCtC4
0L3QstC10YHRgtC40YbQuNC+0L3QvdC+0Lkg0LrQvtC80L/QsNC90LjQtdC5LCDQsiDQutC+0YLQ
vtGA0YPRjiDRjyDQuNC90LLQtdGB0YLQuNGA0YPRjiDQuCDQv9C+0LvRg9GH0LDRjiDQv9GA0L7R
htC10L3RgtC90YPRjg0K0YHRgtCw0LLQutGDINC+0YIgNCUg0LTQviA3JSDQutCw0LbQtNGL0Lkg
0LTQtdC90Yw/DQoNCtCd0LDQt9Cy0LDQvdC40LUg0LrQvtC80L/QsNC90LjQuCBDcnlwdG9haW1h
cmtlcnRpbmcg0LfQsNGA0LXQs9C40YHRgtGA0LjRgNC+0LLQsNC90L4g0Lgg0LvQuNGG0LXQvdC3
0LjRgNC+0LLQsNC90L4NCtC/0YDQsNCy0LjRgtC10LvRjNGB0YLQstC+0Lwg0KHQvtC10LTQuNC9
0LXQvdC90L7Qs9C+INCa0L7RgNC+0LvQtdCy0YHRgtCy0LAuINCvINC40L3QstC10YHRgtC40YDR
g9GOINGC0YPQtNCwINC/0L7RgdC70LXQtNC90LjQtSAyDQrQs9C+0LTQsCwg0Lgg0LLRgdC1INGA
0LDQsdC+0YLQsNC10YIg0L7RgtC70LjRh9C90L4sINC60L7QvNC/0LDQvdC40Y8g0L3QsNC00LXQ
ttC90LAg0Lgg0LLRi9Cz0L7QtNC90LAg0LTQu9GPDQrQuNC90LLQtdGB0YLQuNGG0LjQuSwg0Lgg
0LLQsNGI0Lgg0LjQvdCy0LXRgdGC0LjRhtC40Lgg0LLRgdC10LPQtNCwINCyINCx0LXQt9C+0L/Q
sNGB0L3QvtGB0YLQuCDRgSDQutC+0LzQv9Cw0L3QuNC10LkuDQrQktCw0Lwg0L3QtSDQvdGD0LbQ
vdC+INC90LjRh9C10LPQviDQsdC+0Y/RgtGM0YHRjywg0L3QuNC60LDQutC40YUg0LfQsNC00LXR
gNC20LXQuiDRgSDQstGL0L/Qu9Cw0YLQvtC5LCDQvNC10L3QtdC1INGH0LXQvCDQt9CwDQo1INC8
0LjQvdGD0YIg0LLQsNGI0Lgg0LTQtdC90YzQs9C4INC/0L7Qv9Cw0LTQsNGO0YIg0L3QsCDQstCw
0Ygg0LrQvtGI0LXQu9C10LouDQo=
