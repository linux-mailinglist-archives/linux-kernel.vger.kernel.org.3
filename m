Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AAC54F915
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382682AbiFQOWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382597AbiFQOWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:22:20 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC2747051
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:22:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r5so4194671pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CldH2UOYNI8h/Dk7SccrOemWEn3Hh+cNeX+oU7tFa9E=;
        b=A935eo2HFOGvgUcBAF3kxlliX/kghpFEYbV4xf+xCRIHxbzyBX7XTPN7zHbtgwph27
         GMFA0pXAFXtiC17JEY7lOPy1R8dQC8MoDPDbnMqwghNvJz7l43CSWCPFlWfIEDDSvxDo
         OOk9rHelvP/z+uiyaV11atsesKnF4R+kU1QqW77Kid94hRPrRSA4z8VQoxOa+R1PZ/en
         sNfgrkcGd82X70cfqIgXH0hVOTRAK0RniMWdMgBjtOnSG4Fy8YfC7byOZGMBrkaAw+Qu
         ktNJofOybx3SvMO31f4d+RjXyyLLj7Xa5+eGkWmjNpYmWdNZc79WnXvhoGYjcgsq9ux7
         nW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CldH2UOYNI8h/Dk7SccrOemWEn3Hh+cNeX+oU7tFa9E=;
        b=F7ZKLJLXnCNu5aK83MYONM/fuudOi2U5lM6rMA3Ma1oFt3HsAoAdPt6v1OgkxtwMup
         3tGjswIjCtmJyZyLvF0MsSbRYQFvnIFackv0E9ErwRLnvPOYZQh0Q42CrxU4gpmlcDtb
         GI316HDv2vFa63YibwBp6hZn3lgnJkFNcHlSFuUciz8uPvt5V5Km227UrOITL+aiYuEY
         gSUp7nEN5SrDSxGkjTLeS+8PSH3RubxeLzjGV9FFyIh05kRbho0dbV8Sl+qd+WPo3cwt
         ShCEpT3Cn+Z99ciNp7InxV4FWf13hDQUTI8NHp0fY++8Clvwm/4uQJQNdJkxrn9tFqGK
         zjkA==
X-Gm-Message-State: AJIora/7FKlMPneiekNDraIMrGfuyG+KlGT3S26q+qUypA3Frpsxszja
        wqMohWOfQfVcg0zdo9vNHjipxGa1TIGwAhGUn9k=
X-Google-Smtp-Source: AGRyM1vYnBGGuCo09fgIkaMuulX8KjiZGuW5+8SfUN0Mb16JXl25C4Pvrix7CNIFj2RVgPF2F0IUqvNg8jN4Y+gIgR4=
X-Received: by 2002:a65:6e44:0:b0:3db:219e:2250 with SMTP id
 be4-20020a656e44000000b003db219e2250mr9318569pgb.369.1655475739277; Fri, 17
 Jun 2022 07:22:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:425:b0:2aa:366:1439 with HTTP; Fri, 17 Jun 2022
 07:22:18 -0700 (PDT)
From:   Simon ajafor <barristersimonajafor2@gmail.com>
Date:   Fri, 17 Jun 2022 14:22:18 +0000
Message-ID: <CAKf3XJoaG0BJPMfo6vz56UzDFyqUpozN7Zn0Z8L74Xt_EyFgpQ@mail.gmail.com>
Subject: =?UTF-8?B?7KKL7J2AIOuCoCw=?=
To:     Simon ajafor <barristersimonajafor2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7JWI64WV7ZWY7IS47JqULiDsoIDripQg7ISc7JWE7ZSE66as7Lm0IOuhnOuplCDthqDqs6DsnZgg
67KV66WgIOqwnOyXheydmCDrs4DtmLjsgqwgc2ltb24gYWrsnoXri4jri6QuIOydtO2LgCDsoITs
l5Ag7KCcIOqzoOqwneyXkCDqtIDtlbQg66eI7IKs7KeA66W8IOuztOuCtA0K65Oc66as6rKg7Iq1
64uI64ukLiDrsJvslZjsirXri4jquYw/IOyXheuNsOydtO2KuCDtlbQg7KO87IS47JqULg0K
