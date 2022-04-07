Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196A34F80A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343675AbiDGNgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343664AbiDGNgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:36:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9977524E27A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:34:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so1772325pja.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LecENqONxNDBAseFsv+yDhFyPls8aMa2Pn5px1MzNgs=;
        b=SNVQsECUOhAnMXWe+UjUMFAgdsqd7XUifjb4bfJYOLZnIKHBi4i8MdLoYD/VJN5npQ
         ctsVWpetAORfAvD7qB8u2UbugFjzvNsmGsw/T6yAhncEMsHFcsagKYtrBWv8ohdq33ab
         vLCxRcy9Kioj6o/JFfvgp61Sym2XdXCXyG/O90k5emR50NqxSfuIL6KkDkoEY1mF/YnN
         UVeNrY0mILt0tNCs0eggKzXS3PNaW4S1PCaIgtFS4awdgOWs9+fAVdgXb5kDxd4uTFLu
         UcjFWXIaXpsyY8HNt2FUPxsPBe0eUQqfKGpELLKCgvV/DqOo8Opv2L+WTLHsrQrfAHUV
         yZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=LecENqONxNDBAseFsv+yDhFyPls8aMa2Pn5px1MzNgs=;
        b=7IRHLtK0V1wnIJwlg+3IFekZIJ0JjWzi48bup+IhbaY/57J4i2Fs36l/68X6BsIbyd
         OUXCvpb0em641Pjstee7808BNSq6c309c9nylMJ1w+zGhazNsUmS1j75FyLEYzY+SOyU
         3KzdHtk2PDGi6LcJKChBokgFu0Gluo8PntuAgTmPZT2AZbZ6Pa4z8QQZXipVEDZu/sct
         /orwn674qavJLC8H8und52dHAQJ34Pum4IkdmGfq7XHuWedwHLGyDdyJDewwcfPYDD1A
         aU79MXkJiq7FuswPUA9V6VrltXjlP3vr+baAey69yVgvnrNUVuxJmFBpPY1e0vVgxL+J
         QzXA==
X-Gm-Message-State: AOAM5316XeB2HU13fezEZg8n4UWkWUi8q0plorVuZHdbd1+b4cGftDQk
        2o671BUObXfWLx9jf3EfS8EdAlbnUzwc2Y+/kp8=
X-Google-Smtp-Source: ABdhPJztaQyJVTQQO0bplq/CjXZv6Kqhm68pusBvfnH3mv4EikoFL9nd6mhtZhdmhSLh4XApKqV5uVDdcxfM+79zWBs=
X-Received: by 2002:a17:902:ab01:b0:156:f1cc:6d2d with SMTP id
 ik1-20020a170902ab0100b00156f1cc6d2dmr6619175plb.127.1649338448953; Thu, 07
 Apr 2022 06:34:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:a01a:b0:7a:9fe0:c3c8 with HTTP; Thu, 7 Apr 2022
 06:34:08 -0700 (PDT)
Reply-To: anwarialima@gmail.com
From:   Alima Anwari <nadiazato3@gmail.com>
Date:   Thu, 7 Apr 2022 13:34:08 +0000
Message-ID: <CAM0zFyo5P_HRgkynMUqek7=2XDBHvMqoGPKw5xbErv5deE1tWA@mail.gmail.com>
Subject: God morgon
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hej k=C3=A4ra v=C3=A4n, jag =C3=A4r Alima Anwari fr=C3=A5n Afghanistan, v=
=C3=A4nligen svara
tillbaka till mig och har ett br=C3=A5dskande problem att dela med dig. jag
kommer att v=C3=A4nta
f=C3=B6r din respons.
Tack.
Alima.
