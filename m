Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0152D1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiESLqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiESLqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:46:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26D20F4E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:46:06 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id m6so5460377iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yDhm1ebirOIgsqZE8PB3tSGrpGYRMbeKDIlkUVMccAE=;
        b=Wlcq4W/YMAlSKJPnP6wcb3P3HZ3B1zzL1AViEHKFk8YzW8TIAbrEkREoYu0P7+0TQX
         a02oTJbUowVaUHRAgIDMKAtfXEdtlJKv6fjlaQtWDsuY5AU8epUz6PXzQWHVyfvV7OoP
         NSTXoGz62QeDsa27ETOQEFJCEeVWEwaUYRy/QBCcratMPWzELxCMRL4rRdYvK4APeRVx
         7Hncrs3awrt93FWo4NzOgeMxxEpIC82WKaP8GaWiNkuynLkjDlazry0CUgy5Ib+Q0otg
         OQ7mmTxrQW5Dw2uEhslTXTegW2+gFq5k6dSJ6lkx0t5jAlV8t6A5PWAbcbkV0CoNHm4m
         SPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=yDhm1ebirOIgsqZE8PB3tSGrpGYRMbeKDIlkUVMccAE=;
        b=aKb8PEB8kj6x1FS5GBr2dMovw8a78dGk5PqCZi+u99XfCCyrKDpaclBCXKk4yoS578
         r43Je2J+27W5OkDnHD51nmMEzut22Go4z1cfjiEtZrOIaSz8g2rRPk9fKJgwsl/y4g+j
         AwWIvMjDufBwB9v2bhYbUSpBcpO/kAAvctTFAFZ8rwszCCeuS01VFm+mcSPMCFj5TTPm
         Ks6XoRh+Tbtoh34xEOjnn7I8QiVpLhNNSIvFm8dTXdlCE6VyrZoaQvyTpBRIpmRNJq3A
         Pz0KxcgQq+Bdr599KDu7H+EgEPkf4vCjwGvIGd2Iz6q1jnW6btj13m/LQ3r/Zd4G+XTk
         a3Vw==
X-Gm-Message-State: AOAM531ErrJGeFUqiEC9WJNX0J0HB3+uSaJizF+YdzPsRDVg91t35KLw
        kqD1+quHptuucaUok3EnhL5CHTgjfJXWi1U4yRM=
X-Google-Smtp-Source: ABdhPJxwrKeuSyUTRobdBfLWpY6jAaH0ILiluOEAq+QsExmNAie4lyqWq2bwz7DuqzTEcZNCZ+aDhOi1Apgqdh8nP1o=
X-Received: by 2002:a05:6638:1687:b0:32b:bd36:555d with SMTP id
 f7-20020a056638168700b0032bbd36555dmr2585055jat.302.1652960765983; Thu, 19
 May 2022 04:46:05 -0700 (PDT)
MIME-Version: 1.0
Sender: noelinekasse@gmail.com
Received: by 2002:a02:c768:0:0:0:0:0 with HTTP; Thu, 19 May 2022 04:46:05
 -0700 (PDT)
From:   Orlando Moris <kelvinedmond612@gmail.com>
Date:   Thu, 19 May 2022 11:46:05 +0000
X-Google-Sender-Auth: j01b1UFbCTPzPhvfHrDGSkiAwqM
Message-ID: <CALZWmmz+o-1ZdRjVN+hKSU7gmyewn3Y2v_xO9L2wC1p33dbq9A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hola, tenga la amabilidad de informarle que este correo electr=C3=B3nico
que lleg=C3=B3 a su buz=C3=B3n no es un error, sino que fue dirigido
espec=C3=ADficamente a usted para su amable consideraci=C3=B3n. Tengo una
propuesta de ($7.500.000.00) dejada por mi difunto cliente el
Ingeniero Carlos, el viv=C3=ADa y trabajaba aqu=C3=AD en (LOME TOGO) antes =
de su
tr=C3=A1gica muerte en un fatal accidente automovil=C3=ADstico con su famil=
ia.
Me estoy comunicando con usted como pariente m=C3=A1s cercano a =C3=A9l, pa=
ra
que pueda recibir los fondos sobre los reclamos en su respuesta
r=C3=A1pida. Le informar=C3=A9 sobre los modos de
ejecuci=C3=B3n de este pacto, cont=C3=A1cteme en este correo electr=C3=B3ni=
co
(orlandomoris56@gmail.com)
