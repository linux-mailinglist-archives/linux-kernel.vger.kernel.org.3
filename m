Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718415919FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbiHMLRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 07:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMLRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 07:17:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FA9DF0F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 04:17:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t22so3128647pjy.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=pGw7CfF2Lmxvr1yguV4Wa62KbxJjTFIOO991rU/4wJ8=;
        b=N97TLn4zrTIPB8jKzojU9PVHSx5YeGQRBATjiqwsxa6vLeUWQmGA7vk1hFwNbkq6Ps
         Nsyvu8qhzBGZtoP/vhaMHQvbotLRsfRQS1Vs23bzLzjXrSk3JAL7G78lCa+L/EuXVGx1
         7mzBCpbFGf8SRI9EnN/yyZqbym+L6h7WFFAsAQHtD9bVr/+kAhNyzCMmRgPXjxM7Cirv
         mMVpSdwzTM+Wvh9O2WeImzoSsiafNAPhP7cnVvKI8M9YYp8y7jmCRMcClwqt3XLfeqVS
         UwO1GCR95LVWLlVdpgnyTY/Bi4k1uPeRa14OpaKIXDh1ZzS3uEQbqR+G4AvfdHtifJ8e
         aXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=pGw7CfF2Lmxvr1yguV4Wa62KbxJjTFIOO991rU/4wJ8=;
        b=1lP2Rmj0d57fVf3uhJuFfUPNJv5JKxjvh860lgewCs2SG6GLAXoO1idZUGbAQ1ZMde
         7+fkxitGW4JXpTazWWaFFzsTXwqkhyAqXjggZ8NFFQremZXKdWqZBNXTUcCEcMqSZBgC
         hF6BevwtPv2x28/IkdugyywNHhG02n6BoUFGculveqDPkwZ/UZYWKBM++JkDpco8vFrb
         7I0JxZBlv4J/W0CMOab5SVk9VH60LCyDjjgtrJAsU4bb8JXdYBzBS1ottKsYzhW6Fc7f
         LmszE2GhXq6d9HMEnjcQB62O5xOUHnrkzH8iw0fRVvGc++K98GvsuMEkvbm+OozR/jdx
         R/Rw==
X-Gm-Message-State: ACgBeo05hlWIzXsIe+1PMUQ9KcnJEtuUFmrTmhMwV4oUphbbzZZHURL1
        TMv9ZjUFX08zuIOty7gNqUfPjByruqcDgSrVAVk=
X-Google-Smtp-Source: AA6agR72l/OQvNve0ELSrP2m39QKiFNQZ80tMxFehGP+phzfg8MMTJaqnNdMqH7Gnxrig0HiEmx6Lxbfkewn2rynB6I=
X-Received: by 2002:a17:903:110e:b0:171:3afa:e68c with SMTP id
 n14-20020a170903110e00b001713afae68cmr7983995plh.12.1660389456829; Sat, 13
 Aug 2022 04:17:36 -0700 (PDT)
MIME-Version: 1.0
Sender: kalyrnelson@gmail.com
Received: by 2002:a05:6a10:bb14:b0:2d6:6772:bc10 with HTTP; Sat, 13 Aug 2022
 04:17:36 -0700 (PDT)
From:   Nadia Aleksandrova <nadia.aleksandirova@gmail.com>
Date:   Sat, 13 Aug 2022 04:17:36 -0700
X-Google-Sender-Auth: uT-8waHLZAdk7nm77iB6OsQwUC0
Message-ID: <CAORpc6r4u_XUieYbZr3=PVidgCjnk7f0xRk1GAAtYLe-WAEDmQ@mail.gmail.com>
Subject: Proposal Investment
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

My Name is Nadia Aleksandrova.from Russia, Can I Invest in your country?

With respect,
Mrs.Nadia Aleksandrova.
Address: MARSHALA TIMOSHENKO ULITSA, 21,
MOSCOW, RUSSIA.
Email:nadia.aleksandirova@gmail.com
