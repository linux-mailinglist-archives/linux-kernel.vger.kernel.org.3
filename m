Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE24F8202
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbiDGOpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbiDGOo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:44:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498222B2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:42:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h63so6949790iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=UuJTBzu/eGZ4npPewznRg9lw8SsyifRgiZNRIVVCuYY=;
        b=YoY7qkteLjCjEy33AU4Wtf1G3cRlYhLEAW1hrycW1Ejuxw1HdMZfr5ScVvFYx0CfsR
         fwRBfrrQDb42Zv4LAwHslhAAVOe1PpPDtlgUCvC1f0OF3biF6MMDZHFbwij0H3r/XamG
         jfGQe3j35/OUNufi2comWe3lMS4kdKkLjbtT2Wdzws17CzSdlTGu0hzukC5aBwCx3aHJ
         zS7iZBkEwhjDPAdXbUF9Qnr/cdEunCwpRDhji3Fw7R4wb1xdU5+WOzAXoGTV3cru7GsM
         ASvYRDCcthBpSIdsuB6VU1uoLKyNhhupif7qaWJyYLdT2DF1XdMgrZiXhEoN/LgXGe3M
         bkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=UuJTBzu/eGZ4npPewznRg9lw8SsyifRgiZNRIVVCuYY=;
        b=XMBLXpZmv93ShXz+6Zh8TAcWiUKVIqXCKt3RILZCum7356P3m66DrWGi4h92u3OCwd
         rYCB3Ck0WLcgNJA9geU0j0W0vniYDFrB0gxKmyrJE1XczW80WzngvN0tTfrg5JfPXvY0
         dpp8M1CSfLz7/7V1Z1x4wCupoEnVahDhJUnk2xo96xbsLmd210XPEv+cUJQODPEStsjJ
         iOJjf73+WoU1nKPCZcvjTcLJh/5cFPx9qyGEpE/ltZX0iAT6Gs3DjCNz7LktOTmv7N7E
         1RY3WAvuG9yryWS/zLcrG3uY4/AUSOkpLMYZP9L1OD3dEE1ozLk5N/n6R4fJlfWovDXo
         GPWA==
X-Gm-Message-State: AOAM533KDrpaM/PA4AjrcTTFqwCM1EFbakXusvdtW4yogXI1E9uZGByM
        qQdi2YXkQhDKNwLMQ6dZiXFZOAxpDSU0rPbYd7U=
X-Google-Smtp-Source: ABdhPJyMJ5dUWadzIj9DWnQ3d7Tb3uwFJ4YXPvq7yICK73gVT4DSPjpkD8vTwBeqyud3klhv0c0QR4iUKYD5flfElaA=
X-Received: by 2002:a05:6602:2cca:b0:646:3d03:a6da with SMTP id
 j10-20020a0566022cca00b006463d03a6damr6314205iow.121.1649342542919; Thu, 07
 Apr 2022 07:42:22 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: barristermessan@gmail.com
Received: by 2002:a05:6638:397:0:0:0:0 with HTTP; Thu, 7 Apr 2022 07:42:22
 -0700 (PDT)
From:   Kayla Manthey <sgtkalamanthey@gmail.com>
Date:   Thu, 7 Apr 2022 14:42:22 +0000
X-Google-Sender-Auth: xdFog4A44F0nYEf92Mq74g1p-LM
Message-ID: <CADsZzQKvfkDcx7Z38d+cTpCLnbMLyK-LFu=5Egb=fAJa0OerZw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hilsen fik du mine beskeder? tjek venligst og svar mig
