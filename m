Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD0D4B910E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbiBPTRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:17:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiBPTRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:17:51 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A916FDD3;
        Wed, 16 Feb 2022 11:17:37 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 24so917900ioe.7;
        Wed, 16 Feb 2022 11:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYG9Ag/0WYIVGvDwOhYR1IogyRvQjAUQGPdeqrMEsbw=;
        b=MnFJ/TQN4xnur7sNvTLMAI+P+RIgVrVtXYLFyfwXk3edKU9RUTULpRA/wOsyPM3doh
         j6g6eU3KGKrJG/TcFuPdmBmrtD841A8b8OAQZrVtZpuq0bJFPzFswJu2vewdrmJXcgRx
         kMagCkdAJ9O3yCjw8c2t3RjiBFaXc1SzVuuKuFfNcFiinXyq48LJrf5RhvA+xa7oipwo
         L5hpu507FcVT7Z9SgoaBRw3hxX+47J30h+7iDGySju5RfNrBzGH1G5MlvPxRJMMh+3Gp
         oxY2kAzy4pAe99WUGL9P0M8JmXzNQtM32anzPbWgjUs5F4yGRlCZNQ4yAr+WXdtb39rN
         caFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYG9Ag/0WYIVGvDwOhYR1IogyRvQjAUQGPdeqrMEsbw=;
        b=b2nJBYzSgxA+OV97uOozcwJHO1eDxcO0RBVUhPaIAXm7L18Sfwt0PqrRAXBG8rxQnw
         Dy8c77x58jkwMOof6KBUHZvD1wUICqDzyoj+hPLSF+qT87DR1UgDcFtDP/T7rEbuY8a5
         P5GVuwrAps9vNXyyq6Qw0DAPyVF3eG1H3R+6ZEzXtE6yVROvP1VJBe2ODdGBrcsUrG9S
         gfV5qdr3a/aVEYt7Iu66TCnzS4Qsol5KQT4MKzZObFNxN6nDcdD1wVtZEcCkvRELl2mn
         cqjI3dykQyNEGyziOSyMF7wqx1yiK4iyw5pj/pbmy/LOgC+84SFp0zc38SQxDIgHgElV
         0p7w==
X-Gm-Message-State: AOAM531Z2fIHTcctAR4nyQpa988uwvRai3bl8fm6PlXHh7sq42no4Ptc
        s+sItrJeUMpw0yPqoIMDKUQB1Oxp98ITXtBYAQE1DvBxevc=
X-Google-Smtp-Source: ABdhPJw06roQWoqZr0+47oBj9r9Nu5rTBzmw4HMrqKFU3MwothIGqaNY9AOoEGPvm2EPwWC6d8z8V9vBKcVO0IlyShM=
X-Received: by 2002:a05:6602:2ac3:b0:63d:d5ff:78fa with SMTP id
 m3-20020a0566022ac300b0063dd5ff78famr1092415iov.146.1645039056784; Wed, 16
 Feb 2022 11:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20220216180822.GA3300192@roeck-us.net> <CAB95QASWWMvSSuuwQU=TwZX-QcU=hRPCJVQ0E6Bh29sc4d66Ug@mail.gmail.com>
 <7f3fc06f-cf4e-2dc6-e68a-917117fe8895@roeck-us.net> <CAB95QARa=XQ0LEEqM0R6YvBDrK1GRn=R+jszagMuzBKdo3pBZw@mail.gmail.com>
 <9e14486b-36c0-5869-a368-98b90b4dcd14@roeck-us.net>
In-Reply-To: <9e14486b-36c0-5869-a368-98b90b4dcd14@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 16 Feb 2022 20:17:25 +0100
Message-ID: <CAB95QAT+vGLEPg3JYtfaj98Dv=GFqP2Fi+KoBAXAo__8KrTPMw@mail.gmail.com>
Subject: Re: [PATCH v4] hwmon: (asus-ec-sensors) merge setup functions
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 20:13, Guenter Roeck <linux@roeck-us.net> wrote:

> Nothing as part of this patch. My fault for not bringing this up earlier,
> but that is no reason to not clean up the code while touching it.
>
> You _could_ submit a separate patch fixing everything reported by
> checkpatch, but that is up to you.

OK, thank you!

Eugene
