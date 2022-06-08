Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609E5543F59
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiFHWp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiFHWpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:45:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEDF251022
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:45:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o10so28937192edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=NMISyN+FxZ7s4toXYHIz7uHu2mGvH4LfRIG+wXe5SoM=;
        b=J14JJhgG3gPprIa+Yxi5UZYdwmmRqr50pUDzGwzJBETNWb5KaOjMqrbLmMQFMtm5BM
         wpEwUrYpWlpgFwe5uBTRSSyVE0Ypx8G+Susx6Dy60n23eU8R+tcMljdUdgQjIv+2FKHn
         uwHKiq1cwA2MkZdrOjIyGZaX2H1vwLRQNxlwrQXiMsZHfNphOJXfZBctT8+gC0urzieB
         Q6IfWZbtio9Ozhax/N32zib9suBb0VjxUNVTj6frbyCKFQn6QLQIBfqj5cLvezf3tgZU
         uYTK3FXAd1EA2nukN7QC+SmmfJGEwU0IuNSvaNmUKa+G7NKmnMREB2r/ughUe1hOdbb0
         5PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=NMISyN+FxZ7s4toXYHIz7uHu2mGvH4LfRIG+wXe5SoM=;
        b=T/wN4kFUQnmbyMs0qz4SXyc+msZi5p+TDyF2RYhdpqn5A+PjSHOo2RDQ+OYR8v/9Wp
         xqnbh45O+tBPMsuVngyKykCx4arndq5fwV8M9caF4scv4UGsYha7XRphYOpKtRW2VtA0
         LBleWPOc+Zl2YiecpvfqJYigcvVNzzOxtjHTfHEubfoSq8YLvB45Lgta6YD6AG17iLeu
         WJ1ECI+aOm7FgjQM6IKN8kOfY+KaAvNXbp+K1c5git7WKSnRGAHKfJEVc2HDwf32xuWe
         rHiUF8j+7BGfsKVb4EDzQLYNewvHSm7/NwbPWXrEXeClNWuUrko8c/QexYqj5CxUsPmx
         neJw==
X-Gm-Message-State: AOAM532yRMFSG2OFs+biv2WBvAnmD6dMiuBJ+g2vwTWKAXsUlssKUwWv
        iR9Tq+OzJjxS6n8lk7ZrjN/KMKhGEIGsI61kTkY=
X-Google-Smtp-Source: ABdhPJzaQeOlRWf14PI0ZnB/huSU0G/5EOYv/Wytzpg4/vjKS9hqMSLyfGrs4XwSoZcyt080T9YU/1VZNbCTnkvwN6w=
X-Received: by 2002:a05:6402:847:b0:42d:91ed:82f3 with SMTP id
 b7-20020a056402084700b0042d91ed82f3mr42485070edz.416.1654728316388; Wed, 08
 Jun 2022 15:45:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:640c:2b07:b0:16b:84e2:923 with HTTP; Wed, 8 Jun 2022
 15:45:15 -0700 (PDT)
Reply-To: wen305147@gmail.com
From:   Tony Wen <weboutloock1@gmail.com>
Date:   Thu, 9 Jun 2022 06:45:15 +0800
Message-ID: <CANY0z8S6k=swj2gnoOs=WZUHUbMwxpzaAM-GptbfsmVK_uHGJA@mail.gmail.com>
Subject: work
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

can you work with me?
