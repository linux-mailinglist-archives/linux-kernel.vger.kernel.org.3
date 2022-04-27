Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D76451205E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbiD0Rpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244410AbiD0Rpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:45:32 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD60D0A89
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:42:09 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f7d621d1caso27037227b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=3EFWB19a1Chh2SjnoysoX6/VQoqNb6piiPOAPnA2gVg=;
        b=iNUoG7RdAWleQwa6SZGE2XZFCGj3I1HAAMK+gmh1juoB+Fn9BFCiM7EgV1wag5yHwN
         WyD9H9le8q0T/29q4jHdeGo8mJrKW1UtdLTkCpREx3h3nk2+WV08w72zAAUXH7l7OrJ8
         1qZip/QvKNDLllH8b1Tbiw08iYHjlfPV/lE8rQmfqBVTfSxzXeVXUZN+aIyAL+0OT/s7
         3N5oa2LFRml79pjZud10RlwnSTR2OEK+X/vo3y6zyO1wCo5wZgOig50Yqou7J5AzChZs
         +2k0fVxq5t9mXPMavXLYDsNAanEB0csSXvT9KkzdS5TIpp/wwlU+U2w5yIZol6HH0DVt
         ZDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=3EFWB19a1Chh2SjnoysoX6/VQoqNb6piiPOAPnA2gVg=;
        b=lafi6/rse4UGw3eBrBFTjioWLZD0WyEaa8pcXnZQ7yi5QYU5rxM0DGWzedxzUC/mpf
         tnP78axKkUhRtRJP0uT1R5pIOzQuOztpVGrJrAlXFhOFExYFNQq0WvolA7JWa6Z6NcEM
         GDp/Mmtwzuw8N2OX/srbHeSdlJS2TagJ3Pw4QsOcPlj+snpg7iKH+Mr42SxrYtUJbxel
         yvUSx2JZ1x0J1IQeGYpDySpG4BtWL6q/igvBJbeE+lE44kjtzx4Ya4ZR5+/LIVn7YdBM
         saXGQL3039nKzFnlUTfhCtS0CJzIeSCP33schlnj5VeonXqWdTitKonMqg7q++jhKlFp
         e6QA==
X-Gm-Message-State: AOAM531RJyEGb9z+kq5G0f/y8DNjM9JBjYifMY+zJJhO3CGJZTsTIY7D
        aS58eUbo/kfcsTT8hSJZSqCRnCda46MIMytRFOY=
X-Google-Smtp-Source: ABdhPJz7eJbGpBRWUfMVkZsQwbNdaqIecKqZyYzAV9pLOVXwiV8OhPrika5dknY49DmaGKggtl/GlOXzyBA7PZtu7n4=
X-Received: by 2002:a81:1a4a:0:b0:2f7:da21:ec5c with SMTP id
 a71-20020a811a4a000000b002f7da21ec5cmr17433290ywa.312.1651081327867; Wed, 27
 Apr 2022 10:42:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:2049:b0:170:285b:5d9 with HTTP; Wed, 27 Apr 2022
 10:42:07 -0700 (PDT)
Reply-To: awoonorpatrick301@gmail.com
From:   Dr Patrick Awoonor <colleyking04@gmail.com>
Date:   Wed, 27 Apr 2022 17:42:07 +0000
Message-ID: <CALJPoxq-5LQUiFdYu0ZA7tHKVqrB7PGdrzNu2SH_ihxmxJ5awA@mail.gmail.com>
Subject: o
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did you receive my previous email?

Dr Patrick Awoonor
