Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB672537288
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 22:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiE2UfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 16:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiE2UfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 16:35:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9833A7B9F9
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 13:35:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y13so17474165eje.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=aDNxhq7cO0G133zHYyAXQ9dRvMXQqkJvV1cOKC4Kad0=;
        b=R3wlwKuF6FJ6hiGsy+zZ57i/JLDKKTHtskcPhD4onH6niq/U5WzessWnLfcueT00de
         RfI/JILnBs72lLMiGirkBiZv96RAYfc0EPREyFQ0Mi+USlcRcd5GSNvWav6/K0BIfA7W
         VbtTmCIvdMIEX+s37Lyo+HmfDoNT3HCHnYwgE6aMRWGin/Q541UZXozbWFgsCgHCzAUb
         Sl98aYD2BeLg+WZJg6DkfLRx6avd3bIqxMx9P6XjHSfX0sBA0GcndZ10WP4MCcsyWroA
         XJtI2D5ZdTwAJSA5MB/gz3b9ytTLeAfBfOZwpuR/uGx2M0I89GvaGI/Mxuhalb01zx8B
         C8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=aDNxhq7cO0G133zHYyAXQ9dRvMXQqkJvV1cOKC4Kad0=;
        b=roH8nuHfEeadbhFxXz/UvvDM2+PJZkUuUywaMNarUmS2w78KlZkFHvn1mnayEd9fd/
         ToYBgwqteMiPL5RtaiEt+LweDswxd7nv57PikLIvI8tjYN4BNjKhB+yhAkd4HgjeclVb
         9iInii+WjqcjbTRmJHKGcyHbgqUjicgrwrmdWNqIrro3lo/s9p6YYurBg8331ScQpFfH
         IYP64tSSKddgeXeeY+rX3vyf6PyY4xh84RMSOtQ8mzu/haffN/utJH5W/UD/mZeMEVbs
         gXCOXzij4vaIYk2Wiec5QC+93ymQfPKSPC7QisKo6iwHz4RBIjM+guYNoJwtBRhoU9GW
         4xiQ==
X-Gm-Message-State: AOAM531aG1zrdNkF8Yo2/kQgawuruNSYmFnXieyUqi5LEHLTABhI9Ytn
        9ab7nFC/8IH7RZd2DCxs8r9nITRA4uLDe2f50Q==
X-Google-Smtp-Source: ABdhPJy1tAXoYuWEDNgVLFNCozObgn0QMZ9Tkyd1sk77N/5hZeT/J3woZS4lOLLppB0iNPnzBF0rLpf1ry8AUI/U7w8=
X-Received: by 2002:a17:907:16a4:b0:6ff:15a6:5d0f with SMTP id
 hc36-20020a17090716a400b006ff15a65d0fmr19298467ejc.4.1653856503154; Sun, 29
 May 2022 13:35:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:587:b0:1c:eac9:fa70 with HTTP; Sun, 29 May 2022
 13:35:02 -0700 (PDT)
Reply-To: sr.ritajames@gmail.com
From:   Rita James <yashwardhan12@gmail.com>
Date:   Sun, 29 May 2022 22:35:02 +0200
Message-ID: <CAJGQ2odN8yr1vp2b4kGPC4baWn=hv94e5fz3CLjUcU9dQp=QoQ@mail.gmail.com>
Subject: For charity works
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings dear,
I believe that you can help in setting up a charity foundation for the
benefit of mankind in your country, I sincerely wish to establish a
charity foundation to help the vulnerable,elderly, poor and covid 19
affected people in your country under your care.

Can you help to build and set up this project to help the poor and the
elderly in your country? Together we can make the world a better place
when we help one another sincerely from our good heart,

I wait to read from you today to  know your opinion in doing this
noble project for the help of mankind in your country,

Remain blessed,
Mrs Rita Ije James
