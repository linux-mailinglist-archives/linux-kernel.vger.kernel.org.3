Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC1355AE54
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 05:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbiFZC6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiFZC6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:58:09 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE09765CC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 19:58:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ay16so12236760ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 19:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=aT1sw4m4Agr0F5UoyxxRFIViLo6ffv+TYGmHogSjXGo=;
        b=p/DaixlYtjrJxt0TZ9Sv0PspLH4F4gpAQfDxd2T6KqC1SHP9iljS+DwZTMfPiVSSGm
         F/yNzbwcX3bzuMK/1r8IAdidUXoNi472FD+5xEchiaxU5Sq/f4nUM5bs2KzE38nQDDEZ
         xSboCrjSiM+wm/jrg/92deA9oYzxIYEuFDC4v6npNzzWb+JsMCzxVQlhOP/J5Ouy0uLi
         Z7+yA39BZEdGRUHmW3xbx5TQB4S2VCry5+wcWHVQ4OBH4rBTSMkxbT0Jgm49FOL7iNyZ
         eJjfuW2I9E7w0ML0yN3iKNPtc1B9yptX2/H88HdKh8PtQprUzdCaXhiksW5fAtIU0eIH
         t/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=aT1sw4m4Agr0F5UoyxxRFIViLo6ffv+TYGmHogSjXGo=;
        b=ttXbR85T52oCR5kA6p3NqojpMTY5la1qWhFqldad8AGWzUs0BvOkabJ1Gm+9q+brfz
         pZOJoeZ9VCFw6tWid0xnqKPf1WCfeQS4s/wxaYMRbzSLfhuhuha8emK7AsTIZ34KBUoF
         BUj9HnJ5UMLv/hQKA2exwe+yF4uqCosv67otAt467Z6BKFX2/YXNwOPt0j2Jzm5s/lRU
         gISAHucexAHrc6+ApnGOJpojgp3KOTyer8+xiU8/+vzvVqgNr7PHOGzHlkl5lZUwwovh
         CoNdcHY1L6XDHPSQhw/jjpCIaARoDWMd4+EsQbl2Anpje0qqWjw40xNgF1y/wG7O/phr
         21Ow==
X-Gm-Message-State: AJIora/pAouOyupb+gNo7UGurGJcYyym08U8dXw6IDebiU7MoupKHv78
        j99+l+lv3NqAgbl4AJ+WPh6P+TuA3KIPUjJpP3E=
X-Google-Smtp-Source: AGRyM1ugSbCDNnHpCb0lHalta+66K0E8Up9pyta5m/WjutEeClM5wDgsnA3eyhUSaZXFZvkZaFOFWCa0CuHHdyv6tMw=
X-Received: by 2002:a17:907:2cc5:b0:711:d50b:287a with SMTP id
 hg5-20020a1709072cc500b00711d50b287amr6181154ejc.47.1656212283268; Sat, 25
 Jun 2022 19:58:03 -0700 (PDT)
MIME-Version: 1.0
Sender: jerryojomah@gmail.com
Received: by 2002:a17:906:7306:b0:6ff:31c2:22be with HTTP; Sat, 25 Jun 2022
 19:58:02 -0700 (PDT)
From:   mrs marie brigitte prouvost <mariebrigitteprouvost332@gmail.com>
Date:   Sat, 25 Jun 2022 19:58:02 -0700
X-Google-Sender-Auth: kxr1f60VkmaWOTB8ethgMxSh3l0
Message-ID: <CALqLPnenBJaHG2ho-J_j2WZA+Mx98T=PMFWK0Zefx=rNSkwZ6w@mail.gmail.com>
Subject: Dear Old Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_3,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
I know you may have forgotten me, I am very happy to inform you about
my success in getting the money transferred under the co-operation of
a new partner from Venezuela.

Presently I am in Venezuela with my partner for a better treatment; I
told you that I rather die than to miss this opportunity. Meanwhile, I
didn't forget your past efforts and attempts to assist me in
transferring the funds despite that it failed us somehow.

Before my living Burkina Faso I left a complete sum of Nine Hundred
THousand Dollars,
with the western union money transfer to transfer to you as your
compensation.

Now you are to contact the western union for them to commence on your
payments, Ask them to send you the Nine Hundred
THousand Dollars, which I kept for
your compensation for all the past efforts and attempts to assist me
in this transfer.

Here is the Western Union money Transfer section

Email. westernunionmoneytransfer.WU@financier.com

Remember I have already forward this instruction to them and they will
be expecting you to contact them to commence on your transfers.


Bye and stay bless.

But never forget to inform me whenever you received all your money
because I have paid for the transfer fee.

Thanks and God bless you

Sincerely
mrs marie brigitte prouvost
