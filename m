Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1148BE69
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350922AbiALFrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350916AbiALFrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:47:14 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0593AC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 21:47:14 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id h23so2060628iol.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 21:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cTX8+aELljL75aGmFQLFVAGHxGfTYO/25DOtLiHIZIQ=;
        b=bKzb5aRGA74V1bqhFOmGFfMg6Jb9Jyp7e5cf4TBfM1ffmgdfCZxqLFwcHDYl5BLDSF
         uOdS7NMxGVMWNMQhu38q4x5nbYrd0cNY1n32j3p6Hl9UuYh+0ZOE9a69thX0cTiidUSZ
         cTZZRPlBHyg9fdwI6DIOoxSi5SBVXxHAgBpRdF8xDxSxWLTOXo7LD9CDha4HRr/O5nCD
         mRqTPwUa0tKq6azUhkFrQuugTzXw+rahEvbL9xnqJQmb3JUmvl6cR6nARbXt2xzZMJqq
         qTRfL97FRAx+IFX4Lgflu7QClCbgB0WFKlFbkFqgNoyDKg1A5hhLy+rIcEBRT38DnQId
         V/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=cTX8+aELljL75aGmFQLFVAGHxGfTYO/25DOtLiHIZIQ=;
        b=oL3yvA6ObzJ+4IDgxsv8wngwPcUhB78yHsrGTE34gluHobo5wbWuLFzBXKRwz8MU7q
         xMQqAXIhvIetKacT5S69f5QFwhnafzkN1djQIcQUVI1ACXqShcTV0R7hISae/dZs1k+q
         CFiYBdv4/8WnSbsaoATBu/tVuPwCN9Moq707XxzC16U1vF+NKs83pIH12PiP4aiR9oAQ
         oZ1C9HMo92Fnq/gkH83lKRbmkt2luNI88WQBTrlD/z9aepWS26zJ0RUoPkF+lljhmJyN
         15PlpF3qt4DI7NSfMZ030QonvIvJtX82dQAQ/lSbbeQJ3rAoEG1QQgfpsutNJJBXl30C
         tiKQ==
X-Gm-Message-State: AOAM531zCHJ/mj1oA0GydQIUl1uBqG3TmjJJz+Sw6ohS/9XfZDHo8+Vw
        Z7Xlr/hDts9LopjHgk/XlAuIO0heWULFMD16SIE=
X-Google-Smtp-Source: ABdhPJxdvH4loSwkwLc8eU34LkuQT5SPmjTddBs00SMRZ0cItdUZRWaZpcL61N0aD2bh94Pdb9Pa7MU1lbqqOfRlf04=
X-Received: by 2002:a05:6638:2395:: with SMTP id q21mr3800812jat.313.1641966433495;
 Tue, 11 Jan 2022 21:47:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:3e54:0:0:0:0:0 with HTTP; Tue, 11 Jan 2022 21:47:13
 -0800 (PST)
Reply-To: charlesjacksonjrc@gmail.com
From:   Charles Jackson Jr <tysonfury322@gmail.com>
Date:   Tue, 11 Jan 2022 21:47:13 -0800
Message-ID: <CAF-wYcna4da6ytb1qdW6ymvJP3ezBCpiVKLYWPj1miQ2QikRZQ@mail.gmail.com>
Subject: =?UTF-8?Q?Herzliche_Gl=C3=BCckw=C3=BCnsche=21=21=21_Antworten_Sie_zur=C3=BCck=2C_u?=
        =?UTF-8?Q?m_Ihre_gespendeten_Gelder_einzufordern=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
IHR E-MAIL-KONTO WURDE F=C3=9CR EINE SPENDE VON $3.500.000,00 USD F=C3=9CR
WOHLT=C3=84TIGKEIT AUSGEW=C3=84HLT. ANTWORTEN SIE UNTEN AUF DIE E-MAIL F=C3=
=9CR
WEITERE INFORMATIONEN

E-Mail: charlesjacksonjrc@gmail.com
