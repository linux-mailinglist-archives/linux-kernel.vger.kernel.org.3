Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5084555557A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 22:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbiFVUrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 16:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiFVUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 16:47:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393ED3DDE7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:47:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g25so36728519ejh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=D9ilZiPgmpP7VYJbbsxdChNthsQl6saeoB6vRr+GE7A=;
        b=iiMoojM2nZtefunaHnGBZCsFxdzVWW2uUO3yurbLfE2JbAoTVvCSVxK+OBBzZ6G0wB
         sgzhksVLmgJgx6CPX4/Kx9obEYojLUWTVaacN6VK+x9xxSIuiiYimZ/Ez2ejsJg94LaV
         CDg9rBdNAveeAVvyXAdO2B49rNrNUHFDYSdZDUIG9vKTRO4GnnRVqe50FYNEfu6QEpaa
         jjqqqbNznXoKJqQTKQ6Rij06OSLe1gcmCMCIuH+2ASL+rmokf7yJ32udmvY4/pTR73yY
         yWCUNlETzAk59VUHhvI3J5Pwp6zMq6g+e1IO3P3UutmE1zMRnAj+IThwXdshgAOnsCyo
         JVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D9ilZiPgmpP7VYJbbsxdChNthsQl6saeoB6vRr+GE7A=;
        b=ZTZYHHo1JXGIzf6hcofeAAJ6VniZ5GZ9h1qg5v1B++UpqdIg90vJAscRp4n9sgVmw+
         MA8E6n9qPhHt+ZX9lpu/61FTBJ2sOiO8cJFuTOguf3GaRoxPi5p3RziKA3vtqWx8Y2Xa
         ahZzpQvhrvekAE4oyCEusG5dU+Je1IE4PfTlvWLm1cQc8tgB4oSC+0BrNxXN9dA5VHue
         NVhOjd/TByow0gv4sK7Hc4/tyGylEiTx5wi8PK9Rpr0pK0jZXeJZyGC3zaHMCgSD4s+q
         SzzcXXfJ8aMfB7yK+bf8C4FyTYP3foz7q3ktWRYgqKdZ+qhpDX+J9/OkWM5aW0SNWQRv
         1+tw==
X-Gm-Message-State: AJIora+xNyTVzIsYtg3QJqwT8AJcEDMgXGLE02Q98LsL+lqtZzJW6mBY
        QxIt8kqUJg9CB7uihQ29UrKyAze+hz1xwhGezws=
X-Google-Smtp-Source: AGRyM1t51MiCJs1BDcHAshb6bmHU1fLMS0XpAr86z3VM5sgVxbI8Mb9jH/XrcqRfrWQq6HIE71H9V4u+aVzCZpuq3OI=
X-Received: by 2002:a17:906:b795:b0:722:e662:cffe with SMTP id
 dt21-20020a170906b79500b00722e662cffemr4753635ejb.121.1655930855858; Wed, 22
 Jun 2022 13:47:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:f:b0:1f:5285:3c99 with HTTP; Wed, 22 Jun 2022
 13:47:35 -0700 (PDT)
From:   Johnson Obedy <thisisjohnsonobedy@gmail.com>
Date:   Wed, 22 Jun 2022 13:47:35 -0700
Message-ID: <CAM7UOsAEboqME_Sk-zgsJqKkiMt_zAjn=L5DH2c-tBZyzv3y0A@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear,

My name is Obedy Johnson.. Please, I have a profitable philanthropist
project (US$21Million) proposal that I wish to share with you. This
may not be your area of specialization, but it will be another income
generating project for you. Please let me know if you are interested.
would take care of the expenses, just your trust.

I am waiting for your reply.

Best regards,

Obedy Johnson
