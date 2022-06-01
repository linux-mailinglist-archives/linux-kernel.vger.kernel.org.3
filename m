Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B835253AB42
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356231AbiFAQqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbiFAQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:46:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E8D9D07B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:46:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v19so3000763edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=gdDSYTz4HLleYXYYZhkXmXYvgvXXeTGsPrJjEFnLWucWUiTfXajPohGOkMQ8FEFeg/
         yWVfLgN6/KcphgSOPSidE5a0ZboFhUfYozwk1bjVePpNEMz8DK336WBGmlxNQ+oAZj41
         KnbdO2zK011Ar4dAO75RYjCkQCdAP71LuCJJFBCCdrx1K5w0Ighok4QXEvrYsB2RPVZp
         cQ+ieRG6A0zxTYvdN4WXcaBv8mtXUlRpIhHvAeujMOZiIcMM7xLdwrV6zumnrOoXNSq5
         /9V5vQXCr4kLtazdebsxY4V9wmAeUvUTSbZ3AGdl1I4n6ZuBWM30caYXr196m1szOkZv
         xgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=sKQ+5sp9ARO98lGukM1t89CGSzbIRxsdgXWCR7XYsKnxbC+zFGS4Cz8oUFjHxODn1f
         vGx7UacpagiQhCKxQj7aC8WBYtndroQ9JQHNYy65dKeJczoLbIRaOP04sjD0bX2x28rx
         CqNQbw3RBRKXlfuQfWpdMx3gbIbvQdeUy7sHfCMeg3BFcpbllbukLRGvg/2Xi+LhX9QR
         PtHfku9cEVf+Ig0nNUxTv74myQf/p4n63DYLMM9Usnn9hxM7sGhA+0AJldXqSnRI6OgZ
         6XBoteu2tQ9oHF7yZg+jbdGFXcJHiOwin+QKYNxPZZ22I8LIyUJoBL9vDys0wzCO2KSB
         6A5A==
X-Gm-Message-State: AOAM533PgYdTaLvipIzktoudIX41bBi9VFvTgIjFfIbM1yo8dyzDioea
        LLeZLQWuqon/wQwvQy9t1GPu68D5+7v1vq7yNZ0=
X-Google-Smtp-Source: ABdhPJzFOzvRrqDk1G7AYVWTpuB4XZQeeWFFXGAu+aMAbSKm9Ri9yhD0L2SG1JxLJRA9/eLlZRREtyIzM06GHAWPVJI=
X-Received: by 2002:a05:6402:2925:b0:42d:d019:1716 with SMTP id
 ee37-20020a056402292500b0042dd0191716mr708829edb.110.1654101990465; Wed, 01
 Jun 2022 09:46:30 -0700 (PDT)
MIME-Version: 1.0
Sender: amoudiatchakoura@gmail.com
Received: by 2002:ab4:a609:0:0:0:0:0 with HTTP; Wed, 1 Jun 2022 09:46:29 -0700 (PDT)
From:   "Capt.Sherri" <sherrigallagher409@gmail.com>
Date:   Wed, 1 Jun 2022 16:46:29 +0000
X-Google-Sender-Auth: eE-15i9zFmistn7OK9iTruK4w-k
Message-ID: <CAGZPmGH6UG0rPtbC2=71DcrtCDzOj1PiVvUoVQfD+xrGv02iqA@mail.gmail.com>
Subject: Re: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5L2g5aW977yMDQoNCuS9oOaUtuWIsOaIkeS5i+WJjeeahOa2iOaBr+S6huWQl++8nyDmiJHkuYvl
iY3ogZTns7vov4fkvaDvvIzkvYbmtojmga/lpLHotKXkuobvvIzmiYDku6XmiJHlhrPlrprlho3l
hpnkuIDmrKHjgIIg6K+356Gu6K6k5oKo5piv5ZCm5pS25Yiw5q2k5L+h5oGv77yM5Lul5L6/5oiR
57un57ut77yMDQoNCuetieW+heS9oOeahOetlOWkjeOAgg0KDQrpl67lgJnvvIwNCumbquiOieS4
iuWwiQ0K
