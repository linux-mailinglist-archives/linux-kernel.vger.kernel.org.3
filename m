Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64E851E187
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 00:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444658AbiEFWEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350991AbiEFWEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:04:52 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E8D54FAB
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 15:01:08 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v66so8960369oib.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=fBJI/MP6krRWe/PoIWFEpS30ms4YXSqiHQHNmhGcguPgrGBeMRdljuoklq7KaphZzf
         otNpdlaqDfcFtnvkjq24Gf1cg1D///FLA1Wn6guhxAm4IkpTliyLZ27TRbZgGxkAlSDS
         kyEcwGMye0jzHeSqnXtoU8owkcLqH/rHMRTQmDkvseiddT0HKvdv0LGV06WybUM0yFEx
         W8KyW2mbWJGtq2Ez2Xz3ZaWXylCkWdyRj91XtXbirrLD6NUvb1TZhpY/kbi1IMEXlAcH
         tXxY4lrH9rR4PLhTCHlM1gqitODRhiY7L0XvTljrJqqpJM+0yDLC3vMQqcOHy8MRup0c
         PavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=afVlqH4RqroDrlxwdEiX0IQq8vFTMeh9YkCZpUJezVb0yqZdnyxmgFQVCi7gNudWq4
         EiGoyWoJMsxU/LKGdmpIDQhzSdMUAJId7mcDvtGB8+AJ6Vg3le7pucxhbMy62ZmTo7hr
         ZIqiNkI5aQLMrVXDWHeh2WiXjSILeGTqNHHlDwufF3c/8Lv6TgSfF/5d3H4AfUCgzQe1
         XDZ4CUfikcqw3kvAhLaQjQZ7E7+L5E5AS4tBuE5FprVjeaPCb8I+L7D07mHzPoFTxHbs
         sJJrs+v0mGKbR5i9kwKemoXZH+qMYBhzD4tPPFPoNw3pUu0DBd9AbzyVqRmn1qeU5cLA
         AJTQ==
X-Gm-Message-State: AOAM531+PX51tO12DCJhN7W//S8ZAyEyZ8d+oPUdw+uu5VkUTmpjNBxY
        aCr8vrq49PN22ZGK9ZSUfocQYcU/UXDUx0+F6kk=
X-Google-Smtp-Source: ABdhPJxo1JA9yEAl8i05PugQmB/525OZVbaYLs2kqCA7VujdUP3Hk6EnFIcXn/sa92Iur5iCecLexKhCmUI+8FEi/YQ=
X-Received: by 2002:a05:6808:2220:b0:326:746f:fa95 with SMTP id
 bd32-20020a056808222000b00326746ffa95mr2478251oib.137.1651874467255; Fri, 06
 May 2022 15:01:07 -0700 (PDT)
MIME-Version: 1.0
Sender: djatolami1234@gmail.com
Received: by 2002:a05:6808:1508:0:0:0:0 with HTTP; Fri, 6 May 2022 15:01:06
 -0700 (PDT)
From:   "Capt. Sherri" <sherrigallagher409@gmail.com>
Date:   Fri, 6 May 2022 22:01:07 +0000
X-Google-Sender-Auth: JD7iN6QNkDi_9G25BvFEEGPTICA
Message-ID: <CAGcNsU3CHSgMYOKfz0nkAWjGnvMpT_PCgxnMi=Ri1f6cb0QwWg@mail.gmail.com>
Subject: Re: Hi Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5L2g5aW977yMDQoNCuS9oOaUtuWIsOaIkeS5i+WJjeeahOa2iOaBr+S6huWQl++8nyDmiJHkuYvl
iY3ogZTns7vov4fkvaDvvIzkvYbmtojmga/lpLHotKXkuobvvIzmiYDku6XmiJHlhrPlrprlho3l
hpnkuIDmrKHjgIIg6K+356Gu6K6k5oKo5piv5ZCm5pS25Yiw5q2k5L+h5oGv77yM5Lul5L6/5oiR
57un57ut77yMDQoNCuetieW+heS9oOeahOetlOWkjeOAgg0KDQrpl67lgJnvvIwNCumbquiOieS4
iuWwiQ0K
