Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED85691A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiGFSYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiGFSYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:24:36 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8443A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:24:35 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-31c86fe1dddso101070497b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TO6/mxdpvxjIQrnQr4myQaKWw+6ocKr/HUy7jAILl3M=;
        b=dXaCAZbMFAQyhVofs8M5W8GOzX+D2AfTeyziiuGWrMZ6FawQyXhCz0zYx7InfdwLzB
         ND6aeS4NCxuYcbNCcJDcIwP7zvT/wx0XIkoDQ38l+JWXEuVc/GSCwZCfqB6FDfBHuZjw
         oKaO+5JlFVqYYJxOQRnubXrr1MpGoDzDdyH58rWFqzjomwloOy3t6vb6X4DBQUAXwz4f
         cJb6lzzw8XHPNWoI4QrV6MmV2kEdUiw9+ZsyXQGuRU/RnWrNnZ5ZTgrE/AOpeUd9pYmz
         qH55gNRnSH5H3pZWFzEbiBr9KIc7Hhs1T5JjBfBQozy0rMqPUctC9cZqlCBmIeT0Ga2d
         L43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TO6/mxdpvxjIQrnQr4myQaKWw+6ocKr/HUy7jAILl3M=;
        b=3Iu5zRL4BRMoI7lLa9DRoubtTsuHZG+ceretbBa28gE0gCRP/El4HEdi8iaImZBMGg
         t9jN/8AXFsb32rsg19k26Uc5s8Q1zJCdHsa5aj5Nxvb65qm/GyNFe79iAhCZj6NeTMAs
         7Dzhf1tHDKOsIMcXt/rNi9+Hyqfn7r+vE1xLYXJM9dpmURzRtNk4Cl8RmexJZxDaNrK5
         Rzee4vg1iT1XJP3/CuA2T8fRgcR7uubt5bp03UxAR5sDEOBoPqQPOPMk4VePopFDQ6/F
         zWw7mVpt7OVEqUMmvdJpCjrRudL91gFdYQaqypxxp7OXAX8BZKhm+cUyWnSgCPUfL2Fc
         Z1/g==
X-Gm-Message-State: AJIora/zE0kmi8KmGUlvfDPYokW/zINnNbxuJcTZVTJ0N1ohB7O7OLVn
        LETjHQDthMf4ppyU1d+FTIjU17fPqd0XXII/lhY=
X-Google-Smtp-Source: AGRyM1sGgt3Sh+emt3f4LXIC7tJeCE0gSsscWZJkwyMdBKhoovj8OXxAEsMDhM0X1DxqAcilNl4IX+scE4RScXPGF6k=
X-Received: by 2002:a0d:f5c7:0:b0:31c:b37b:90cf with SMTP id
 e190-20020a0df5c7000000b0031cb37b90cfmr15150378ywf.221.1657131874874; Wed, 06
 Jul 2022 11:24:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:a798:b0:2e1:f8ed:7f5d with HTTP; Wed, 6 Jul 2022
 11:24:34 -0700 (PDT)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <momohanthony7@gmail.com>
Date:   Wed, 6 Jul 2022 18:24:34 +0000
Message-ID: <CADL6TagiHHKDnJzx4+D4hkTn+E45J9fNo=FzJS0di0u=2=gNRQ@mail.gmail.com>
Subject: Hast du die E-Mail erhalten, die ich dir gestern Morgen geschickt
 habe .?.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Mit freundlichen Gr=C3=BC=C3=9Fen,
L. Ken
