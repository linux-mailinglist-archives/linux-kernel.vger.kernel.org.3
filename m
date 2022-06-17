Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943E254FE0C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbiFQT7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiFQT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:59:10 -0400
X-Greylist: delayed 3434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jun 2022 12:59:09 PDT
Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E8580F5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:59:09 -0700 (PDT)
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HIClh3006775
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=20180315; bh=ZmAqNJuLfmfsYgu5jMcqB+wBTXu+TXAHQlUwnDGwK0A=;
 b=KoSwd7IfkI2xcVC2AQL8ZNEAAMeCmtE3d5TZrikrAn4TPnOulOdSzatLl9y2lubOUhPY
 xrgGP4fAdbwg7SQA9YvkffLYxyzZc3O8e78SnCO58cKSxiUsNtSEEFjTMVHJQLyzXpih
 WATuJYxedufZOdzIEJop3yyD4Myt5G1/PlM/GdVMxmEQGi4MCUZCqvnHo3FX38L1C/rg
 AylsWnBF6+AWKW7u01zjfEJWifyWWs46yyzSnBDbCRHI61olRT8T7UD91PR7i4Bd9tGq
 SOEp9smO+O/NlZiBn6TG9HkaWb+UJApFMYjymMqIt4oRs3rXbDmol3Ha6HxcE49D5fdc Hw== 
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3grtcnfpgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:01:54 -0400
Received: by mail-ej1-f70.google.com with SMTP id h16-20020a1709070b1000b00713a3941a27so2425963ejl.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmAqNJuLfmfsYgu5jMcqB+wBTXu+TXAHQlUwnDGwK0A=;
        b=AKDjxoV0RSoJAyqX5mnPMO7O45mVwTGrQlEVQTBtRw+NIFI9FFBfRCEi88guHyxI4/
         j5uG2BMURNHiJnvCC1dfalGgq5xZa7RCUGgxfQs3lbNw3oE5bCUX2OKS8n6XqyfCgsB2
         RSO8R2E1S3Bpp25+a9QFOTbQ6gETsLsxssovydI65Hobl7cv5dK/JUNQOXJWAoWWof/n
         79ubiSk/9vPNxcX93b+YiBa2+qnfNGu9KQTKQWlHnAPevbWNz7eJNtJZzwRup1wWc61q
         Uk6vOO2SPmJoBRkN+pYbtWrkNilLqhwnJ8vSr6FmiZ5Aw3Ll9R7eZkmBMewOiizEl0MV
         9ZKg==
X-Gm-Message-State: AJIora/Bf1VNJyI6txWxph5+Bnqwb44WGuRVeldRJzliNCGG6Dzj5AxF
        mfQTcN47eW/HxNMnt2u1oW2JzAu1S4wpRVyupays1OuNWeIP3PNb4+TlXJrnCUtxzGbOGmXW6eD
        ZAkC+Ogn3BKelDEcta6TTuyaWqonHAClKl/kl9Q0=
X-Received: by 2002:a17:906:1003:b0:718:c108:663c with SMTP id 3-20020a170906100300b00718c108663cmr10435969ejm.252.1655492512658;
        Fri, 17 Jun 2022 12:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tSUMf+WyxrpcxP7qhOOtlBbeDF1oXavM63Vdyh487Ew2bedZFbO7QzadeUMHPoe/JHz/bscs+8/Ipk+NYhslQ=
X-Received: by 2002:a17:906:1003:b0:718:c108:663c with SMTP id
 3-20020a170906100300b00718c108663cmr10435959ejm.252.1655492512472; Fri, 17
 Jun 2022 12:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220617044755.37535-1-huzh@nyu.edu> <YqzKrdI0JBORlptt@dev-arch.thelio-3990X>
In-Reply-To: <YqzKrdI0JBORlptt@dev-arch.thelio-3990X>
From:   Zhenghao Hu <huzh@nyu.edu>
Date:   Fri, 17 Jun 2022 15:01:41 -0400
Message-ID: <CANeN5i90+fYzA2Kw9ro=n831531YJsjhO01GkywPRmmEe3Y06Q@mail.gmail.com>
Subject: Re: [PATCH] Fix use of uninitialized variable in rts5261_init_from_hw,
 when efuse_valid == 1.
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: komnEdBu1EGC7Hf7G75j6ixVUvn6HDYw
X-Proofpoint-ORIG-GUID: komnEdBu1EGC7Hf7G75j6ixVUvn6HDYw
X-Orig-IP: 209.85.218.70
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=994 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206170083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ops, thanks for the whole story! I just started building allmodconfig
yesterday...
Didn't expect it moving that fast. lol
I shall definitely check the mail archive first before sending out a
patch next time...

Best,
Zhenghao


On Fri, Jun 17, 2022 at 2:40 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Jun 17, 2022 at 12:47:55AM -0400, HighW4y2H3ll wrote:
> > Signed-off-by: zhenghao hu <huzh@nyu.edu>
> > ---
> >  drivers/misc/cardreader/rts5261.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> > index 749cc5a46d13..f22634b14dc8 100644
> > --- a/drivers/misc/cardreader/rts5261.c
> > +++ b/drivers/misc/cardreader/rts5261.c
> > @@ -403,7 +403,7 @@ static void rts5261_init_from_hw(struct rtsx_pcr *pcr)
> >                       setting_reg1 = PCR_SETTING_REG4;
> >                       setting_reg2 = PCR_SETTING_REG5;
> >               }
> > -     } else if (efuse_valid == 0) {
> > +     } else {
> >               // default
> >               setting_reg1 = PCR_SETTING_REG1;
> >               setting_reg2 = PCR_SETTING_REG2;
> > --
> > 2.35.1
> >
>
> I know Greg already replied but this has been fixed already [1]. Due to
> a small snafu [2], it won't make 5.19-rc3 but I hope it will be fixed in
> 5.19-rc4.
>
> [1]: https://urldefense.com/v3/__https://git.kernel.org/gregkh/char-misc/c/bd476c1306ea989d6d9eb65295572e98d93edeb6__;!!BhJSzQqDqA!XNoPCVw0ozReMMJgSQCoCufrU3q574GV-8L51akkn21EMod9SPhZ4-B-i9hLyXx-4_PB98y8PJkK$
> [2]: https://urldefense.com/v3/__https://lore.kernel.org/CE205655-557F-486C-AF6A-099749208327@kroah.com/__;!!BhJSzQqDqA!XNoPCVw0ozReMMJgSQCoCufrU3q574GV-8L51akkn21EMod9SPhZ4-B-i9hLyXx-4_PB9y9cjFEA$
>
> Cheers,
> Nathan
