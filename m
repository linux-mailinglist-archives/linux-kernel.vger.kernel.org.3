Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B66A511F00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbiD0Pkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbiD0Pko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:40:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C817556C2C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:37:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j6so4137865ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNqxfkqFclQA7PXgOfrmIV8J2NtUqFWiqkPpYcES2h0=;
        b=gZUesZ+UkvRyTGGiwlhLhgiwcgfhcr6YnGD75pwQU7IODUksKldYQkWR/QX21VRjMX
         iOMydL3N6dCsZQbDLndyHb6qBjexcHR9uoLJG8kouc6sTc8n9E3++meWL26y95Au6kMH
         aUY3Q6crgZq1bhA2L4u3fwvUPlXw0qu5Rxdh6O8HkDc9kczVraSiOib7Shnvu8krL87V
         pEjfo0am84dDiaP1h4TZ6kb6wnIWEUjTURI1BKLVNxQVfGn02p40JB3F0ZJixoUXUAar
         xMdf/TSItRI49Z4sOlqtDiHjVAE/QYz0iY3GPnMRvI91i2N2ri1fNoohLHAKfM8op1yy
         22Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNqxfkqFclQA7PXgOfrmIV8J2NtUqFWiqkPpYcES2h0=;
        b=av3tKJjGEURMYWfZsxznOh1AnFlFnaleU+m1fFlPBEK1/RWDVXqMtJhekJtCBR4IP2
         oiihsoXC4eb3BuiKC9ocd8l43AofwtZTUKamMok4TkbPTMogXs2lG9aMhdk1SHw8mESW
         wTaTZS+3dDwncp9XJIWB6OMEu2s2JP169eWALKAG636DbqsK8b1oflCjeBgKkzaFU/0t
         CUgpdFmjXN6+li9e4ygaMtjUcf7wFOQ9JDdlmX0a57ExAIm8vEDFT+7q7oy4d95yZJam
         NKbTebfa2ollChMLN9ly1qYGU4AzAY86D+EfBDINBQ//kS+amSvijBvVNuGz4kmCtpmI
         6zAA==
X-Gm-Message-State: AOAM531uG+BHDbC0tgoPCpI1aQJ4WSu6qgeRat15A/WbOGwIs46DvTwZ
        ndbUI/wUjCM56V2sNqbQRvPCzWowuEFz2YRxZrYhwmMDsrI=
X-Google-Smtp-Source: ABdhPJyxcoedA4AG/7v0zbg4RNRy8/x3P6pyVM4SPXZfJAD1qDqx5sgN+MwOIPT6a+8l0hVZBNgIbWNsGAbBamGB6oc=
X-Received: by 2002:a17:907:7b83:b0:6e8:c2c8:1f14 with SMTP id
 ne3-20020a1709077b8300b006e8c2c81f14mr27432948ejc.356.1651073851032; Wed, 27
 Apr 2022 08:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1650568579.git.jhpark1013@gmail.com> <bba338ae5f9992dbf2a64b388f7702e6b287d8c2.1650568579.git.jhpark1013@gmail.com>
 <YmK/o23YIeXwKlep@kroah.com>
In-Reply-To: <YmK/o23YIeXwKlep@kroah.com>
From:   Jaehee <jhpark1013@gmail.com>
Date:   Wed, 27 Apr 2022 11:37:19 -0400
Message-ID: <CAA1TwFDMpNuWjKDBW2L0q31FHHUcQ8RyrYBpVDAOmQCHV+qxTw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] staging: r8188eu: remove unused else condition
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Outreachy Linux Kernel <outreachy@lists.linux.dev>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 21, 2022 at 03:20:32PM -0400, Jaehee Park wrote:
> > s_ret cannot return '2' so this else condition is unused. Remove this
> > unnecessary else statement.
>
> s_ret is not a function, it is a value.
> rtw_select_and_join_from_scanned_queue() is the function here.
>
> Can you fix up the wording in this changelog text and resubmit?
>
> thanks,
>
> greg k-h

Sorry about the delay! I've sent the revised patch just now.
Thanks,
Jaehee
