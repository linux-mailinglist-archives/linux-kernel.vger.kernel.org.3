Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDB753E777
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiFFLri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiFFLrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:47:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4354F11A0E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:47:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a10so12609233pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=Rcw2aYqllELtTslmtJaclRx3LpAD+5ylT0BLwa6WXZJNa+sL4PAbHQAfmhFTg93I4x
         kIdfFZKq4b5tUlqwVyE9Qu7WMpcNUZBo5ehau2m7wpxuCdLlBVKc94pGs1xNBIBWpHZ7
         y9pMwPXe4G2eiD2ZOobJcJobq8JKEoveOGcX2rgzQ0icMb+QKT0ku8Q7PKBl4PftTGxE
         rBVbsoMUTa5EKnGKiQdQy61EOiv3I6IMv2yQOhh/zv6vOBTfRvNpgwClR8HkNe1wBBO2
         UZaOH1UFmJc3YMQXqeE6oYmIPrj+uSmIKQqg3l8nRF4NfRt0EIxHlEBds7MeT87ay3dL
         Xtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=DDXpaYSKpPQe+9lxvQuqI84h1D6vVEn/kf1rNXGxfqGhHHYCP6B6yHt/7foANVMi+D
         SvdiqLw/bU0UrJmDxdA5Ma2Ahw3c+TQRsqtMxs810ThHExPE0Y+CCL04qZqjk/hZtBB7
         zOs3WdPwg5Du/SdYUOChU0afW4NaF+gr0yTdxpYLEkqC/o1A4o8QRavilfWea9WN97Nl
         8xYAbAPQP//wlwpT/vh/kRz3btPNZzv+f43A8IQfjjRz4YdaGdYGTzLDpeZJwghJ0Fgq
         cIwFXtZzrU/Eu6uFR1yYK79U0olrMS+Bxlgu2pUBr8fx1KvkJpEkvShTNnQO/RV6l1tr
         3zfA==
X-Gm-Message-State: AOAM533TYrneIhgw3i5GH8a2I7xUMT31WZ+Ydp1WevDTaxfR9XrWNzJB
        J9AfvBKTwK55IOyyUANd0+nCzd19QVKZFafyZDg=
X-Google-Smtp-Source: ABdhPJxHi/+KxN0MuqfQ3RoV2GEyBgOEY/BICnxinQG8d9ZAa9ZT6khhPO309ql4yB9LFEYS4gwprLHUQoTYdC4sHUE=
X-Received: by 2002:a17:902:d4cf:b0:167:735a:e7a1 with SMTP id
 o15-20020a170902d4cf00b00167735ae7a1mr7778734plg.161.1654516053816; Mon, 06
 Jun 2022 04:47:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:3a85:b0:83:ec11:fcd4 with HTTP; Mon, 6 Jun 2022
 04:47:33 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikram <kodjoadannou123@gmail.com>
Date:   Mon, 6 Jun 2022 04:47:33 -0700
Message-ID: <CAOtKoZ9AZu7eg35-SFWpEBzx4Qk22zxHSSr7=Aedj05LPNfYRQ@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Dear ,

  Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
