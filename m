Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EBD5B249E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiIHR27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiIHR2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:28:38 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C37BF37D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:27:11 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id m65so8685965vsc.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=MR9VHc9VsFF6ReBVLSZ3bpfSnxfuSaqR39dVcTGoeig=;
        b=O3R7TkOXd9j4NZxQ7BCzKvYRaRJe7Q37eOSvz5eRKVCOSZ4/O295kpplyca3/FhmeW
         sucSt0oqXEkyi8ROGufj+yaHRPErohlnloJjbcKzhDU4pzUBJMXcnPqgxafvbbzQrwbz
         BCMSIOmYD8qVJ9cGGg+pdrZxjQ55YH8PyhrswEyBVteZ5LnwUoXRYdsJzn3Wa9LiEdqZ
         r4wTk8hU9IxOlzQ1rgPNGTs8adltrOTj+7UUQlyM308v247NFxfkBTbIDaQy48zx6iZ7
         w7Mc+c8feHJyPwI1j7EC8Bh/JLOi1O9rsu4uC2ggXoY5QviZ1AIluZbh9T/HYSudZJr6
         6Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MR9VHc9VsFF6ReBVLSZ3bpfSnxfuSaqR39dVcTGoeig=;
        b=Dkj6Q18ONOfN0dCZGNbsmY7+UBQ34D5qP4J1xNjp2o/iYcryibHoyMG1Lealm5n0AA
         dYxP7czatvBFZI4euvtVpb0c9KL4q4MdLFknm2tCt7MYarVBFhE4WhiiH0VTGE4G/762
         sI1XrfBbnu3wVac7U+jxqkl7XXMUbmMcA+PDfnwOOoWlV8o6MNzkh1gO4fJKXcpG3W0d
         nACx0Hk08+30hsJpkwv4uJfnMYTWdT1pqVuiafYQgU7PPylUXUb5Wrc7ydol1rIgPg/i
         AiSMSPZ2/VySTnsen0dV76bHk8yRo87sgHK9KqKVirw6z+uixBp3cqsa8/Vo9z9VMqEw
         P4Mw==
X-Gm-Message-State: ACgBeo3dU8sR49X+W6XVOO0GU+iUX06UtwscJnimuzuktNUtdSV2Xd7r
        emYjl9zNNa7J8FBs1VuhGE31cgAvFVsZ+HW36I9X8vy1VEg=
X-Google-Smtp-Source: AA6agR7r5SoVdSf5Vq2SICdwEss7KvFxt8vq17Jx/NxTK+EwoZzFxbKbp2dPyyGn3UPmIKDjILSy5Jt8aDON5rOSrYk=
X-Received: by 2002:a67:b20f:0:b0:390:786b:96c with SMTP id
 b15-20020a67b20f000000b00390786b096cmr3431227vsf.68.1662657988234; Thu, 08
 Sep 2022 10:26:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:bb63:0:b0:2eb:9822:130e with HTTP; Thu, 8 Sep 2022
 10:26:27 -0700 (PDT)
Reply-To: attorneyjoel4ever2021@gmail.com
From:   Felix Joel <edmond.djamond@gmail.com>
Date:   Thu, 8 Sep 2022 17:26:27 +0000
Message-ID: <CAAORCvWqp=p3Mg-HhF6+7vep6Gg_u6jvbDV7ObHJim+o3vpR0Q@mail.gmail.com>
Subject: =?UTF-8?Q?Jeg_venter_p=C3=A5_=C3=A5_h=C3=B8re_fra_deg?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [attorneyjoel4ever2021[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [edmond.djamond[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
God kveld
Jeg er advokat Felix Joel. Jeg kontaktet deg ang=C3=A5ende dette fondet $
8,5 millioner dollar satt inn i en bank her av min avd=C3=B8de klient som
har samme navn som deg. svar for mer informasjon,
Takk,
Barrister Felix Joel
