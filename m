Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EA24CAB8F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbiCBR1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbiCBR1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:27:42 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC69CA33B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:26:59 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id x3so2040078qvd.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5g4e3FoDZ04w3yN9r9/DrAhXMgzBOA3m1TJsZRCqpfs=;
        b=LB74V1s71KJAopRug7ZclBoN6D00aUe7NnQmke84eYdl0Oc86XRIy1BL2LWnNtOmCJ
         HcvHbKy8hzchOyqDZqAvLS0dMntrTFjlSUxNiQg25Rfo2kOC67yheiJNKUU/tYTBORgF
         alRny5RwvS9ly3kDB0FiQ0Gibo3BCkZ71jC47/q5CRmWGD7aSk1KQbYPMMldIzPBVH9W
         VVd6iLn6uRtnLh4/HjVJ7ksuilf7iGldDvbW9C/RDErjBZDMFI9O6JDNQBzVCKECewRv
         jGFSZtsxN4LF6R665EKdbA3tvYb044LZbOgwpe6BbJCIjkjgBv9sbEQYy8iOqC4kOnTZ
         cZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5g4e3FoDZ04w3yN9r9/DrAhXMgzBOA3m1TJsZRCqpfs=;
        b=iVPYPOcqLgeCBBxQHEEA0g8rsINMwG3ubvwxML6qNpLzle8vkzTOGA4IWWPBtP9RPH
         M38JXT3lR8w4TluDdMeBKUgrznSccZ4ZrVy+nAWBHK0d4Q8U3inIqUUd74zrc75xfJkR
         ut/r0yji9/EGLn+iF4St1skPyvLYlHjEp2Q/j8xA+9C44JaYzwLLlxbrHYZ1H/L5ttfC
         1YBYZb29rVVRtZo3S0DtUfHyZ29lHNA6dWQ0zou5IzJWcq+uH4OS+9VGHKDauq7mA6+v
         YGTV4ZZyhU86l6BU8Ywj2sWnZFmnoUJat45aztDl8tguexlXibkZ9ovDO+FPgHNPKGT3
         THkg==
X-Gm-Message-State: AOAM533M2AiYhrzyC93gSXLIPm69a2sIzpBHyWXp0xOA0SfSEzQEeDti
        zLKIQOsz3UZUP8f4oBUAkcot16nobJF3YxOk5SQ=
X-Google-Smtp-Source: ABdhPJyCD0GZMhmbwW2CTTlmI4eJC4c5yH/eFxWGq0joUGcdKm6BWwdUcQIHhkjO0L/HO5SgNnYOfevJgw9sZiWoMdE=
X-Received: by 2002:ad4:5fcb:0:b0:432:d049:c6d with SMTP id
 jq11-20020ad45fcb000000b00432d0490c6dmr17509351qvb.39.1646242018249; Wed, 02
 Mar 2022 09:26:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:5f4b:0:0:0:0:0 with HTTP; Wed, 2 Mar 2022 09:26:57 -0800 (PST)
Reply-To: michellegoodman45@gmail.com
From:   Michelle Goodman <michellegoodman358@gmail.com>
Date:   Wed, 2 Mar 2022 17:26:57 +0000
Message-ID: <CAAnwc9u5Wxo9fB-=Eg9dEXQrnzkWV7Sa2CtLrxPvQKfj3G12RQ@mail.gmail.com>
Subject: Halo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegoodman358[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman45[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegoodman358[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Danke.
Michelle
