Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5B52BC76
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbiERNCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiERNCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:02:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB9F1A15E5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:02:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g12so2917134edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jiDFAi7uSfAlt1GeKmGkvGkPohJC4SqRn809ugdgjoA=;
        b=nmf0ElobJwF3+RcobiwAJxAY4jTMQ4rSSZWfsq/hzCEyQzOBQw+MUFJ6M9p566iYIR
         e2vqRLztdN8VpUjHAmVC/qkwqu+GGTkh/VoxaYewO4HrePFhpzo66vhYO9wGOUX4kV1j
         fYdifpUHqIw2+DWWtdnKnNc/8OIM/xAxUnqZqT+bSivRk9Gx5dbA7V2vwKbBNuK2gJCu
         za7gmqqyNKSXnpgWiiqC0JchJK7/j+H7Kjq5rs8k4yvN2Jby6DApNq3dGZCcQ9XW+4Bb
         RsU3Vw9py0evC3Deno7gDCyW4GcaacZUjOAVEGA7P3YZNQnK7qECJdnUBBcUdASk+iFa
         EVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=jiDFAi7uSfAlt1GeKmGkvGkPohJC4SqRn809ugdgjoA=;
        b=Casa2JbCgGIjrYp6apURJMjEbiYa8lAVsiacXhhPuuXAhrxq3tknuoampm5adbSZUc
         77HSA8RUdc8e8xGFwuoSx/1GJXMWIFNZ8WiVdVHt22oqxJ5unsE1PFzjUabmHGLXt5FY
         zqDv0SJm2dWrkcHQ97lVw3iQbTkkjV6AyuwvhcGYZnp+cS7kw5F1UxCDxYA9nSBP/lsm
         VlqZQn1YyGB1UDtgExDK4BgVhNj8hFFf5tg6F8A1hCdzqdOHiFuyj+ZZBjrPtvdW3VpF
         Tq0zZejJcTjPO3qBFABx0SEtKor4b8njEQeUy4hP6H2Y098qb9QLqmAoDQa6HJNnjShh
         imDQ==
X-Gm-Message-State: AOAM533m9FKgpTa/SuygTumvpC9qpJQCQmZdPcwhHWOXuZz0RsRppPQN
        HJNsrGkn8ol8xgEApuayMvOxSqN8qMylzkfpj/w=
X-Google-Smtp-Source: ABdhPJyA9avlWha0lQus3ovBd+tb/lZENxMUy0ckaex98LgvactqrmVlmPf4LHIXqnJPAbfAU7VOsoKq1ftWT1Viy5U=
X-Received: by 2002:a05:6402:400f:b0:428:325a:b6bb with SMTP id
 d15-20020a056402400f00b00428325ab6bbmr24897381eda.145.1652878960471; Wed, 18
 May 2022 06:02:40 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: messanameyovi@gmail.com
Received: by 2002:a54:2152:0:0:0:0:0 with HTTP; Wed, 18 May 2022 06:02:39
 -0700 (PDT)
From:   kalay manthey <sgtkalamanthey@gmail.com>
Date:   Wed, 18 May 2022 06:02:39 -0700
X-Google-Sender-Auth: 2maTywhpIEJ_uJ6lSwd-CsKoZdk
Message-ID: <CAJ2-AnCsP8tyMDQihAgWJ0_QwnjCWh3vziQi+iR+XNGYs+8OXg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ol=C3=A1, voc=C3=AA recebeu meu e-mail anterior? por favor, verifique.
