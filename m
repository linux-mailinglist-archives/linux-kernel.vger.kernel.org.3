Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69554E9A09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbiC1OqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiC1OqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:46:17 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455FB62C7;
        Mon, 28 Mar 2022 07:44:36 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e22so17280577ioe.11;
        Mon, 28 Mar 2022 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mMMlhTxzYEHtS4zDmDj3NxQOCx5sRP0SfIk3u1yW/LM=;
        b=ZvC1s/4Bet8rYKjsp5dxehRubPdn+BafZR2k7wib6IArbDyGiacv4YMWVz61v532Gv
         e/khlPkekXiCVV6nzw+x7dTPgnc7EjG3MkC1bxxkWQ9XD3E4HIsS53xxB6iqWpdJjpdC
         KPqhqJuaycmNA+y/McWCMEQfoe+tQEKKj2OLXzAaYtaeNRIYierb4WsWU9akld450LlY
         MzHlZHOb2VEfoWAFcmwrEzKp+H7Ejwo/IXLB5vjCqm+IFRIUA25yhbXGRDxWJKH8S4C9
         rCZ4nuCEowlumz4a6ApLDNeyAbf0q+s6Xnzex+lhzHxcAAWVH7V79IkN4B2L7uNlfOf3
         UzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mMMlhTxzYEHtS4zDmDj3NxQOCx5sRP0SfIk3u1yW/LM=;
        b=igZrath9IOvIb13N1tCWgG80xrmPzTpGdo0QOw2cJ2J7duChqAtpBFSuSw1ff+5Hmq
         cvCXHXVCgZQM0sdphlyYMXGYw6mpJnXapLJiqQUCi3nlAin0zwiue0LHsXVMyevvaOcS
         +arHEpil3f2cZG50Ieh8Q3Hi01DZSaL/myBA4TezXTDkbQ8ZRybpp3DxnF2h4Pt7cki1
         DDyBMffaXi9709DmnFAam5W7yf4g0Ux8wpbk2aMcBpfuwfS+WYohnzuDqgnqc4LB9Hpp
         7GMvbtBWW+1qRwLCdnAQm73biiVOnD+lmiNFzwMpEw62nzJry3fniK6O8uKZwXnkTL3I
         R0vA==
X-Gm-Message-State: AOAM530vTtG1sPID5Ocui/cRf7i8VK6UyjRUwFLsLt5WJ8WkB1QMZzvi
        anIMNBp3XPpo53akSoxOpYfmgMwivEws1FAqVvg=
X-Google-Smtp-Source: ABdhPJzq7pUno8ujxBlAgx6qPk4juTDG7BF7/D/rn8oQxxCXujPRW2VaJ/IyZ7Ktt9Olhnznlmj2rWJ6qDdGh+JPMGc=
X-Received: by 2002:a02:c85c:0:b0:323:7196:6226 with SMTP id
 r28-20020a02c85c000000b0032371966226mr1317979jao.108.1648478675672; Mon, 28
 Mar 2022 07:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-3-eugene.shalygin@gmail.com> <CAB95QASpZTz4eMger46WEa9xWJNmARShBUNb7edJA1eij3KBwA@mail.gmail.com>
 <a1607f0d-9d6c-fb55-d0d2-b57e4fdfda23@roeck-us.net> <CAB95QAQTtVWMs3dOx87G+D_GzGuMjnmPGiYQLqqQiCHT939Upw@mail.gmail.com>
 <a2a3ab35-7e21-51f9-fee2-67f6686b13c8@roeck-us.net>
In-Reply-To: <a2a3ab35-7e21-51f9-fee2-67f6686b13c8@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Mon, 28 Mar 2022 16:44:24 +0200
Message-ID: <CAB95QARqSm=TLsynwfoXUS2+rfi6ghUHekSoPv3JHn0GyaDTdw@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the
 ACPI global lock
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> First, you can go up to 100 columns nowadays. Second, the column
> limit is waived for strings because it is more important to not
> split them. If you _still_ want to stick with 80 columns, sorry,
> no, I don't have a solution. Your problem is with the editor,
> not with kernel formatting rules.

Thank you, G=C3=BCnter, 100 is better than 80 and the string fits. I
wonder, why is the .clang-format file not updated and still says the
limit is 80?

Eugene
