Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6244652C858
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiESAGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiESAGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:06:37 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF9EC0393
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:06:34 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j7so2632229ila.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=cIsLyhsOrD3IttZmOYH0xdsGytqziB4STJnVkL0CNCYV0hIACHkmHs36IcAoZOdkRY
         0VD/+Yr+3cQnqXwRQU2rB704ObNxFR4sDIjcvJ1ThRnbrvUvhNe7uAFCJVrHAHZEjGBh
         A7IKZ8CLO2Jdccq4H46O/JdCET9ReD4KKcel5cF4ysdHuSZG2+CbcszsJtrW7hQcjeXD
         uB5/JwkUWtRfF+9MMM9FlOf3ZtYhrss5ePEONq+kbCVpCp3o68zkiPuJMiDLL7O4hyhK
         DRravWP6aLLcifaULQNHb4VwsLXv1MnylyEgHjB+aOupB17zFU2BTgmlpmorNSIbZym6
         WqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=tpYG1UNovmT4HGs59XfMjdk4ZjRj3d2H+wyLJrr4dcpdVjDdyyguNwf0QMuhrYph3O
         5CcgK5ULQQnlgWPYt0etOda/hx/R/WzqOwkE910IcfK+9+2Uu6f3JskGdIoqxVKmbpjR
         cnvIC0Npy+mr6z4TJj3eQrNF04pKg7tOTlCCb/6j7TggQpBCFdbWsWQInIK/s8+40SPJ
         ilHJjrLsgYsP7Kpp6afygyBIm9R+JDNWghB7+mhtmWVywGYG+zHrLvzeXflnEwhpJe40
         ZhPQ37zrWyOvYo+gNEVZu5dPEEn59ts2yMEBXewdZ3ApnlBm6KazYWdrQpTzzTJvl0Hy
         jxFw==
X-Gm-Message-State: AOAM533mxT2SfC6ADkHecqvXlWNACAIRZN6HeeIN1HpVgsE/KEXzLHma
        8O8krCFrh16pRcDXHd08CCwXSaVcu64UcDeXJls=
X-Google-Smtp-Source: ABdhPJym1gF9Y5SnXLtRCsBL3cXI5cpvyl4FTd05wr3Z/7ii5OH/pAibA2hthqQeHIUxtYypxb6i0RrhM1WYkNBOT58=
X-Received: by 2002:a05:6e02:1be6:b0:2cf:45f3:9399 with SMTP id
 y6-20020a056e021be600b002cf45f39399mr1260356ilv.278.1652918794166; Wed, 18
 May 2022 17:06:34 -0700 (PDT)
MIME-Version: 1.0
Sender: bafatou013@gmail.com
Received: by 2002:a05:6638:614:0:0:0:0 with HTTP; Wed, 18 May 2022 17:06:33
 -0700 (PDT)
In-Reply-To: <CAEMStx4zcNFnAW+Vkki-xmAxhz=KNsGZh3c46Qy=OaUqJD4S7g@mail.gmail.com>
References: <CAEMStx4zcNFnAW+Vkki-xmAxhz=KNsGZh3c46Qy=OaUqJD4S7g@mail.gmail.com>
From:   anita <aline.su3@gmail.com>
Date:   Thu, 19 May 2022 00:06:33 +0000
X-Google-Sender-Auth: nev5UNHvtXWHdQ4s-n6rn8KQ1uk
Message-ID: <CAEMStx5YQCJDDSfUi4CSATmyoqfZAQsp1+5mxa9=tZHJp=ZAPQ@mail.gmail.com>
Subject: Hi
To:     "aline.su3" <aline.su3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


