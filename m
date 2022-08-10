Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7105E58ECC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiHJNHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiHJNHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:07:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E47479683
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:07:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m4so27625144ejr.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=tyiItwVvWaAJcbf3Q+zWpKrJsXATE91lNO2jcXiWOZg=;
        b=P4MyP7RX6EIipwZr8OPTUG1el800K2Ij1L1hpYAwlxWI7qNbRQZ2XZcSz9Fv7n/Crf
         RpQJfygSnSWgIAmFNBRf6osfs5s5BUarn8bJIaAyh9gpJuRkwB5V+PyZ+s2Ay+g34jzi
         O1KI/qjxaKdb6Tv3wRoPyy5Ofj4jRVrn+b7m10Fg74j3GCiKsSJOOA6N3y/7xTV3Hz4Y
         KG7ApUsNRln++27MK/r5U+FEuU8sf9F/Sda2R+mlxfNFCRkeii5LWH+5HSCwhX1AUnJF
         aUkCynGayEPKl/T8pAJfyX4majMvn150GciPKCeFWa7QhaTLBMowizuvDx9RKyxzzsHq
         utGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tyiItwVvWaAJcbf3Q+zWpKrJsXATE91lNO2jcXiWOZg=;
        b=3faC/xM+2YuKs03cVtkcZTI9csLcLEG2Ld5VhuGNK4GAOOUKFt8OtucCUFxpkU7qx2
         JV+Lf0pOWCbcmXRaWzT+ILYvGVLwKq9iGuNxRlIsSQGwbrOM0qsKbapiagaPj9Pof0vW
         9VrPai9x2zxyfMgGwLHxJATIiTxj5CKdDafz3VpXmkKPhjyOl9jVrL01PUU6eNhReIi2
         /kYZD3WEY8CKe+1YoirBeZu45j6VgmYDbGi6l+NlygVIDVIFcPONbno+VPSF1DKEHUqc
         +TwKBFplwaci20Eo6HNBtqdBvITcbwlI47ChoW8PJ3pDUPn+zVYBjbggi3035CxgHIq6
         LHZQ==
X-Gm-Message-State: ACgBeo1tPTHp/rpjBk4X8dNegkikhnn2j8EHQwyuAvDCKaFMq//RSStV
        ruXpepr62LaQkjjCqkMWLgSweSVIiUkPsz6FCB0=
X-Google-Smtp-Source: AA6agR4xqcDQu0NU49rJFWMvw7ypyjWmxSmHsFB5B0n8lkBGkMPj+ycnGXi3kBx7PJnA25dYoRc4oERnR7kAGjO6BwM=
X-Received: by 2002:a17:907:8a01:b0:731:4316:b0ad with SMTP id
 sc1-20020a1709078a0100b007314316b0admr12367992ejc.477.1660136835489; Wed, 10
 Aug 2022 06:07:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:9:b0:1e:d239:3d35 with HTTP; Wed, 10 Aug 2022
 06:07:15 -0700 (PDT)
From:   Ajafor simon <simonajafor1985@gmail.com>
Date:   Wed, 10 Aug 2022 13:07:15 +0000
Message-ID: <CABDeXzdX8_FJJ9A0dAgcc12qnXCmWdAY1GkAAS2d_RB5XoA7=A@mail.gmail.com>
Subject: =?UTF-8?B?7Lmc7JWg7ZWY64qULCDtg4DsvIDsmrDsuZgs?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7Lmc7JWg7ZWY64qULCDtg4DsvIDsmrDsuZgsDQoNCuyViOuFle2VmOyEuOyalC4g7KCA64qUIOyE
nOyVhO2UhOumrOy5tCDroZzrqZTthqDqs6Dsl5DshJwg67OA7Zi47IKs66GcIOq3vOustO2VmOqz
oCDsnojripQg67OA7Zi47IKsKEVuZywgR2VvcmdlIFRha2V1Y2hpKeydmCDrs4DtmLjsgqwNClNp
bW9uIEFqYWZvcuyeheuLiOuLpC4g6re464qUIDEx7JuUIDIx7J28IOyEnOyVhO2UhOumrOy5tCDr
oZzrqZTthqDqs6Dsl5Ag7J6I64qUIOyJmCDqsJzrsJwg7ZqM7IKs7JeQ7IScIOqzhOyVveyngeyc
vOuhnCDsnbztlojrjZgg7KCB7J20DQrsnojsirXri4jri6QuIOuvuOq1reyXkOyEnCDslYTrgrTs
mYAg7Jm464+Z65S47J20IOy9lOuhnOuCmDE566GcIOyCrOunne2VnCDtm4Qg7Ius7J6l66eI67mE
66GcIOyCrOunne2WiOyKteuLiOuLpC4NCg0K6re4IOydtO2bhOuhnCDsoIDripQg7Jes6riwIO2G
oOqzoOyXkCDsnojripQg64u57Iug7J2YIOuMgOyCrOq0gOyXkCDsoJwg6rOg6rCd7J2YIOy5nOyy
meydhCDssL7quLAg7JyE7ZW0IOusuOydmO2VtCDsmZTsp4Drp4wg7J20IOyXreyLnCDshLHqs7Xs
oIHsnbTsp4Ag66q77ZaI7Iq164uI64ukLg0KDQrsnbTsoJwg6reA7ZWY7J2YIOyXsOudveydhCDq
uLDri6TrpqzrqbAg64qm7J2AIOqzoOqwneydtCDrgqjqsqjrkZQgMSwyNTDrp4wg64us65+sLCAx
LDI1MOunjCDri6zrn6wg7IOB64u57J2YIOq4sOq4iOydhCDrs7jqta3snLzroZwg7Iah7ZmY7ZWY
64qUIOuNsA0K64+E7JuA7J2EIOuTnOumrOq4sCDsnITtlbQg7Jew65297J2EIOuTnOuguOyKteuL
iOuLpC4NCg0K7Lmc7JWg7ZWY64qULg0K67OA7Zi47IKsIFNpbW9uIEFqYWZvcihFU1EpDQrroZzr
qZQg7Yag6rOgIOyEnOyVhO2UhOumrOy5tA0K
