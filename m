Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CA95595D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiFXIwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiFXIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:52:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8474766A5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:52:33 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 73-20020a9d084f000000b00616b04c7656so82559oty.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=PJTMUT8EzkUJqkPd5ILJeiU8dJRpq2pSfLo4RUdt1gg=;
        b=B6bcug/cQXN9X4ZbuxHHJlVZr6hnQg963pGyG9h/UpLAKN/mBtwjRyCefXq/xq39u/
         UoqFI0tFw73RA226hYRJ7NgF6XHQsXkQlDuH51zY3vr82XQW4XQfIdF2A0QFNvjpku4a
         8bGo72LXVk/HPSHH0oP0f7YtV2MqGs+7OTqYZAiziWzV99DYAql+uFTQo4MERjukESvc
         RRM3BI+LwCQQ3Cw9XcokRi0hbb2cQrnN4QzuZcCs01xf+TZq6KpkU98WR+IszW1mNziZ
         5h4WC9FZjgjwTZJwWqRwqpABS39V13UduFVi9Qt5dK+GlqYZbu8yngfgdcNj+VuGIl1u
         1gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=PJTMUT8EzkUJqkPd5ILJeiU8dJRpq2pSfLo4RUdt1gg=;
        b=Bmylj4VTek9rblcAFSaXyANhUFAZN9OpAZQbD72u+sTWxDzWtn2ZmbYTbwIB5qbr1+
         IVNTx0EyaB+stu1ffSK2DS6cDNfVF78IiWg1JIUImhNJW4+JF7h8e+hE8H1kBLrnUt82
         /1TbFJ9RJqJZVnriQMDTfq6q+cJKKbvRyFcKlmu2YOlnSTf4lGrqACvl0wt6nxJqXRLs
         8cwyNqrIGZyKt6bslKCBnUQYTSy9fnApLcelt+tYSWmmYiLzn06m7ILzmcJBnqDtVwAt
         Oz1Ru6+t3ZnzZoZj9AJceK4B3X1OHz0s9U7KoDUsneatyaDf+pgerq7H6crxtPmFPn1E
         rfVA==
X-Gm-Message-State: AJIora9F1qlrDs8HpZbKsxYUeXRHigA9hRAgYGmBu/kHTNF5lTbIJ8lA
        YC63x6EJ26jvNJha/ihKXc5ZvrsvGRj/MVoxiIQ=
X-Google-Smtp-Source: AGRyM1utgkfaPqEPJcnV0eeEfKjwi/V4xRFjf3Z+rqXbcDHDRY+o6vCLm5FtogV80LIQIPVZ3xR2daw4erhUDsiZpdo=
X-Received: by 2002:a9d:604a:0:b0:616:929b:e1a6 with SMTP id
 v10-20020a9d604a000000b00616929be1a6mr3768934otj.22.1656060752940; Fri, 24
 Jun 2022 01:52:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: oliverbaruch6@gmail.com
Sender: alfieharry1212@gmail.com
Received: by 2002:a05:6358:5384:b0:a5:9b4e:c0e6 with HTTP; Fri, 24 Jun 2022
 01:52:32 -0700 (PDT)
From:   Mr Oliver <oliverbaruch6@gmail.com>
Date:   Fri, 24 Jun 2022 09:52:32 +0100
X-Google-Sender-Auth: G82WABBKSx8Voz4dAGH4fxg_tys
Message-ID: <CAF2JN_ODqRA9ZDqZZu+8+aYXv5wB8wKwq7U9hjwsdX6g+BpJ0A@mail.gmail.com>
Subject: Business Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
23 Lower Belgrave Street SW1W 0NR, London.
Attention: Account/Finance manager

Hello, My name is Mr Oliver Baruch, Account/Finance manager in
(Premier Oil PLC).
I have a business proposal that will be beneficial to you and me.
please contact me for more details of the business to you. thanks.

Forward your response to this email: email: oliverbaruch6@gmail.com
