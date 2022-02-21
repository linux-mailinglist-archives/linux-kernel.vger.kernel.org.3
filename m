Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B904BE6DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiBURdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:33:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiBURdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:33:02 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EDB1B787
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:32:39 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id w4so18364409vsq.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gjpwqZkz1/PSMwGL+FQYKYjTTY7z/2ciPOSGXNE6GNM=;
        b=U1daSnodFpnZYMPEqHcL/O9bEPd7UkeGDw9GNiiX9wd+rSIwJhIr8mD6Nj3CjBkTFY
         +nyG7QYzCCC7qJjiQM2MTKWdQOIgGddEsoG1POC55ObfD0Ijvwg75lI+1VPejNXPYqhT
         pW8dfmHLh1//QdhTE2Zg76a9pHQZnmCpKXGNX663beReKnQarq8xNzLtipvgpUV9kZfS
         wfToM+pqm7X2iKTEwOTMBK8NtGbogV2NeLvpJx7qHB2/8p/hUymfnXgxQqMOZiLRzcN6
         dKBE9AfnAV/SRsqhj/XzEUooxoG1fnMU8HJhxHhiTCPsOl6TTEBtc7k1X9y4Ie3LBOq1
         rB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gjpwqZkz1/PSMwGL+FQYKYjTTY7z/2ciPOSGXNE6GNM=;
        b=EoC1DAdC9vN+lAgUKqylfnFKiMBu9HSPPgqfBPzZRQCwFuJhcW4lzEntTSE+pUfwa8
         ia0JRrm9H0E1fRhdv/eVv/r3Dewb3FyE84VUp+fhv1wYcT2vJHgoBLZMrHRcvZn6n80C
         HH+1/734XZLEbezD6vTtGcFucOJ5i3KnrxEWEcPb27igdFkFNEWpv/JhP/7Tzd6mfrk6
         jnRYmir4Wx1gr5pSQDYWWndLGJgMNtFe2A6j9+dhh4IaQui8MpliaMmtVZ0vIcDMXBXr
         Tahjb/om569RiR87MVL95WjCToh/wJeSRmNmdfQtAVM3AT3FjbxjPwS0Naw+TeSelqTE
         LfGA==
X-Gm-Message-State: AOAM533DLGOilV4WNMYeLMzlFyKc+y42os9SRa6T1P/SNlntryg2aGlx
        mDUL3vr4xJQUP9+T0ODyafWOOr3WEWnpelcpqms=
X-Google-Smtp-Source: ABdhPJzfAswvA/1ohYoqDQ0TF/Jdzjw2MGJzkpm7meWXr6/kmLsU7cKQHF8NqB/eln9AyxNPJwLiVMQ4XqhPvmcPbsw=
X-Received: by 2002:a67:eb4b:0:b0:303:8e9d:be89 with SMTP id
 x11-20020a67eb4b000000b003038e9dbe89mr8127364vso.56.1645464758028; Mon, 21
 Feb 2022 09:32:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:ab8a:0:b0:294:1cb6:3d45 with HTTP; Mon, 21 Feb 2022
 09:32:37 -0800 (PST)
Reply-To: billcstan@consultant.com
From:   IMPORTANT NOTIFICATION MESSAGE <networkserv02@gmail.com>
Date:   Mon, 21 Feb 2022 09:32:37 -0800
Message-ID: <CAEMV3q=m2R2FpNved_k5PG5Q2ecY6MMmGrpbhBdt7X=r6wE2dQ@mail.gmail.com>
Subject: Private and confidential
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_20,DKIM_SIGNED,
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

-- 
Attention.

I have been waiting for your reply but it looks like you did not get
my message, please get back to me soon.
Best Regards
Dr.Castan Bills
