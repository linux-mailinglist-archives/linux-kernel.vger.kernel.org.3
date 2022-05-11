Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD2E522FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiEKJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbiEKJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:51:11 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DDA14085
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:50:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s14so1365195plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=4kP1SrlImVQvijZfLa/DYuaMhF1rtRMbLjnfGPAkB7g=;
        b=RXupbJGrKrVK+07lLoIgk+QNFAotclhDgv72fAYZdb3kY7E5z8fBVlhBNivBmE/C9k
         MvSoZxp6RhX83o+G0SqAEWVzLRVnu+HqiYIL3JCCD3ofMyFaR0PqW9arWA53Hp73WQ7z
         tLiZG5cqsMgRGOMy82rdrp9FHOPziUgNKs4uh0akXzGmgt4BuVK96eNiXeZQtrHx9VBz
         /dhuBjh+LsCb0u1ihISrhtVGsSyzxgWd+ceR8DOQoMHYzSZ+CwNF1FjpMnmONb/yyjdW
         Duz88giS1TZGDTX56pgsLdy6tWLCu5sR2JlEn9C79q7dR9CQUDmP2O8A53CMLOo5ztqC
         bQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=4kP1SrlImVQvijZfLa/DYuaMhF1rtRMbLjnfGPAkB7g=;
        b=2etWfQWzARElyxunpQpuxrFe8JgNwzrc6v09SBXtfOfVuMkqpMtxpKOhfwcsB5y1vU
         yX4afmiv3bRwB6oGowaoURzsPk7+6Y22wWcxK8yR9DgmCZffc7k1nAe1b9WECHphxoGA
         jGwf0UfCpDdg7w5zoW24Mvb9jlB80hOwPJZdoINvMR2GD7jU5CWWOHW0liP7v96k1kK/
         fZmFyKkMqgMtcb5m55Llvdpnu1iOTQgG6WHYKf0qzzS5HtxCG3vW4MKMLGRdruexFAO7
         BWnhs//PVaSbIs6hIQ2gKsF819izfibqLmSkNA0MttK+6e3wF18QGfbOf3J+H749RrjB
         WaIg==
X-Gm-Message-State: AOAM532JArfsIdCoiVjbBXFRE7+IQVmSW1AYvVaFaWlnjQ9xrpxTtgPU
        IifPEaXSjA7jsMbLK4Su80QueQUBb8VfcoRjaA==
X-Google-Smtp-Source: ABdhPJz6CyqNbI4Z8ml0klbVkoOwH+qyb9Oljtk4Kd4sPEBUc/9gCOiO/egLUb+LVYuVhyKiR3MxsfXGeXjN1xUikbA=
X-Received: by 2002:a17:90a:2f84:b0:1dd:940:50e7 with SMTP id
 t4-20020a17090a2f8400b001dd094050e7mr4442309pjd.210.1652262646828; Wed, 11
 May 2022 02:50:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:9b45:0:0:0:0 with HTTP; Wed, 11 May 2022 02:50:46
 -0700 (PDT)
Reply-To: janerobles434@gmail.com
From:   Jane Robles <mikeuk124@gmail.com>
Date:   Wed, 11 May 2022 09:50:46 +0000
Message-ID: <CALhK1+WydC_u-2pTprPhvJbzX8PCZGNjiHK5dVox=APDsj+gnA@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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

Hello?
