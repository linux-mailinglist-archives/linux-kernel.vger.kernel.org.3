Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EA5786EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiGRQGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiGRQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:05:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00382DE85
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:05:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e15so15976175edj.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=85usSUEiitwz/5MS47HoqHg9REwGFwSe77Yysgl88ek=;
        b=d1bsMy+FqniTZ30hTRNDVs0t2qpCbwM7tvXj9W6kE5qC8yCfyD/hLx+73s/Fmoc9cw
         h8RH25ZJpBxLxly61B/1UHS5tq6Fq4sauhTxo6uQVALS2Ei75LEFlFVbr/Ipw0QwCU1I
         qCUUd+AzoqsNg543VtEoWoVp5jPS605S87RMItWcfDe14hXh0UeEa3eJGOKgVq/Q8Xwy
         gL+BbQm4pod2an9lKp4qq++qva4TUidADhMUMWdQ0rKJHpyvMDnA/W6V+gk7ref+ajrF
         f1QJIpp6Y1LRX8u71V7qfNCUfI3BbsLSgCK5FCmkqKdnZ1+1QKUvEW64gIh8MpM7W2rH
         LZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=85usSUEiitwz/5MS47HoqHg9REwGFwSe77Yysgl88ek=;
        b=A/F49kWUSgssk9PT//jqvJy7J4kGaNVQE0pEUcXgd93MRFSjNClIPGuRrb6wuXcr+0
         9A8Nx3Px3t4griQCG1/yNfwSMZdcnxeNyiMBwQJ7YrhxBlZPWxqs+fgcesCyqvASyZcB
         rID6UJkdi4v73KTD6a+ueC+qgk/5hPy4gjN3E19xqtMmn0QwHWIo1VoSQDECzr/xifBC
         SPfHgDgNyaJ9zKbxDABO6A/L+UwPcDDyEj7KlJWdJXmTmQkdbs876YFSfZcdYAmYyabX
         U+AQ98v3aF/Q/4bz3VBbyYUow5ixR/ZpwhRi6L83ULLkdvk09jsSktyeaFieMQrTJCJz
         yzQg==
X-Gm-Message-State: AJIora8VBtJnAvluWb/BlsWnA/xyt0nE7ztDE69Yz+Y3RctVpHGCEMiV
        86EEJ1rT+rzrjb+/Qj0nC/8OnfPTYT0vbzURKkk=
X-Google-Smtp-Source: AGRyM1tySmPJpQxBk6xBDGcgtfIlfvfFRwsgGjCETuctJB4RiKc2fshLQIoUp43FhtoTNjwscgbuSg6GpptkPOG2a/c=
X-Received: by 2002:a05:6402:3290:b0:43a:86c4:af70 with SMTP id
 f16-20020a056402329000b0043a86c4af70mr37496823eda.313.1658160356587; Mon, 18
 Jul 2022 09:05:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:23:b0:20:553:9eaa with HTTP; Mon, 18 Jul 2022
 09:05:56 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   Kayla Manthey <elikounde@gmail.com>
Date:   Mon, 18 Jul 2022 10:05:56 -0600
Message-ID: <CAGwZt9QkDC-+xYt3NAJuz+CjCHP0wSeJrT4gNoHoLy3nX4o6LA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
H=C3=A4lsningar,
V=C3=A4nligen fick du mitt tidigare meddelande? Skriv tillbaka
