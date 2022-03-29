Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1EA4EAC67
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiC2LiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiC2LiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:38:09 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1953424F34;
        Tue, 29 Mar 2022 04:36:27 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 9so17414445iou.5;
        Tue, 29 Mar 2022 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSnr/fL0DOHnOTrzVso1/gX7ks14ss+/hLpuSw8JUMk=;
        b=p4Qf3pkFfcFoMoNLcvVXecWMKYYbperuvwOHYqgbq/5cOLFFZQjj77PpAC9YrllV0M
         00ttiaWF8Qh+KjW6LJLLkRENhMAt+eGroFTqvIwVFeJfdmDFZa1iW+69X8nlTo7YpobS
         AxmtfxjAOZJCQOeYcShSNuFt6GvAq2xKKdkJ7tQuga3lQTqWFMQfPcJbm0oJoCvumGy8
         sn03q4r0oxfwoD8/tSDSBEdLR0gMAp5Q8mBdMswW+DvTTBNNAgrRaxooH6OnAj0kn700
         dC46QlyfIg9IF7X/f/8qaMvYpaRgJ1o5i7mmRZGIPgm3YE8K5SYFeEs/1okPMCQ2WYux
         BvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSnr/fL0DOHnOTrzVso1/gX7ks14ss+/hLpuSw8JUMk=;
        b=EQVFAhpRrYxIMPUIG4BTiVrRmmPg/RBLWBq8XbFUvDbti9ym/rsZCxeNLzfdlaaMaO
         8A/WGK46yE8mR8NLUIJjlj/5tKJGnnK/vzkouw4kuAOYW0dJ9BjLdotFNQvBqvCXvZfs
         TnypazbM1u2+cLjoKEl+LsdnXZvLDodJvK+jm6ZIHeEjJ0HlGrnDsfbUDVZ3pIeJe0sV
         8p1yD8AoDJtCE731ErJ8HRXoEC4tBOFjJlkphuAdGQYT3CcECYdWANPZ2Lq7LBFTL/r9
         t/+D1plm5Us2sZzDXgcmswZ0SUIUapLleNBPK3Mta76yb5T46vzu1JOVATAMKTxWt3FI
         XJQw==
X-Gm-Message-State: AOAM531/RY44HfA7hV3cKWhcDQPbbIbZFfN+MZv+DvloiNOe4iJ7DBjO
        c9eYJW8USnclnpGiJms83w3bblA2NEx6EThc2uU=
X-Google-Smtp-Source: ABdhPJwo8TR1LeK9Azsw8K68d4kff01Y0tfhZxcrx73QkjjILHXiyuZ2HAok64MM5yhhF4pH0rVz5LPE+aBk6240sMU=
X-Received: by 2002:a02:c85c:0:b0:323:7196:6226 with SMTP id
 r28-20020a02c85c000000b0032371966226mr3970814jao.108.1648553786599; Tue, 29
 Mar 2022 04:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-3-eugene.shalygin@gmail.com> <CAB95QASpZTz4eMger46WEa9xWJNmARShBUNb7edJA1eij3KBwA@mail.gmail.com>
 <a1607f0d-9d6c-fb55-d0d2-b57e4fdfda23@roeck-us.net> <CAB95QAQTtVWMs3dOx87G+D_GzGuMjnmPGiYQLqqQiCHT939Upw@mail.gmail.com>
 <a2a3ab35-7e21-51f9-fee2-67f6686b13c8@roeck-us.net> <CAB95QARqSm=TLsynwfoXUS2+rfi6ghUHekSoPv3JHn0GyaDTdw@mail.gmail.com>
 <YkHZRzbi54t0pZkO@thelio-3990X>
In-Reply-To: <YkHZRzbi54t0pZkO@thelio-3990X>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Tue, 29 Mar 2022 13:36:15 +0200
Message-ID: <CAB95QASaAiuWs8_Gi_qrNiTvkddwzDCeUaHAP=2jTieooe89-g@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the
 ACPI global lock
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, darcagn@protonmail.com,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
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

Thank you, Nathan!
