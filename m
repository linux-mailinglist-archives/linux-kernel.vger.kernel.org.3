Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230B94A53AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiBAACT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiBAACS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:02:18 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0792DC061714;
        Mon, 31 Jan 2022 16:02:18 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso825318pjv.1;
        Mon, 31 Jan 2022 16:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z0XgTk76ywjS8fg7jX/3lUVAUlkvwgxnb1BEJ1GEsnc=;
        b=euhd8+BDHWELpy6ZWmuHm8wjIMgv869CnWKXQwbJ/WPtnLw2yzWuiMBqK0FNPTcUpK
         PhnfbrWdjXryMLSKolN2KRn2PbzQKj7RE2Eo6/5LmfWIJlvrEAMwbT3zg3gKX9wCCyut
         KUDZoKfN02cq4N6Tv0xgTWe7QD7EsLQ3Xg9rh90podRztDhhY4b7V9Iwm0lQy4J03Drg
         N4OrPl2wuASsJI/xriuddAlswYv4vlYsnlt2IZASWPEiWiBOY895jKqiikgKuBtGYURQ
         R/N7rMjNcMBdz02y4ZCsNXElKqXTCU2hOZ9KnvcoLalu4Ev2TaGamSegbi+IuUIP7At5
         BPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z0XgTk76ywjS8fg7jX/3lUVAUlkvwgxnb1BEJ1GEsnc=;
        b=ymJobXOiByqpRSXskoZLsflmAjBKDCQwpSoG8FVpk88nIftE6sQCe94nE1Lrlge9RN
         WyS4TcUpY7C9UisSGyzXzIUcWiJ81U+CKI5n3WDYtM7dJWbKlZ0rRwpJ6UUQJU9f0frU
         fzUoSDw/CgjKl/hA5zsTCtkruzgtGewKMT5v0DDSzf1rXMaHBTfFcnLWgTW6BLq/nxmN
         BvwmaQZd0LScKSCo/hoePAVlUMyujI5RNZ2pmG/3nrkD8Bz83c309yStqq8mOOLJybXB
         IhHGgue6Y9IngHtnHibHVF9tlZ4arup0Vo1ikFY2ongNZw1wcpWuTsK00VlGnN3RzH7l
         5kHQ==
X-Gm-Message-State: AOAM531XoNi5JPVBlmFWccKwIaZDNzr4a7J04siA1VEWhoASg+UiRZp8
        Rqg2YtPSiYc1dbEt9iLWLX4=
X-Google-Smtp-Source: ABdhPJyrnn7CzOgFqXAQV5iY4F3jw1Q8PuwkIBwvYtZ5ZJlKjxqrKIZvr/v59hMx9c7Nm7gew71SDA==
X-Received: by 2002:a17:90b:4f44:: with SMTP id pj4mr27136304pjb.167.1643673737554;
        Mon, 31 Jan 2022 16:02:17 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id pi9sm432786pjb.46.2022.01.31.16.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 16:02:17 -0800 (PST)
Message-ID: <0c8ea878-0a6f-ea01-ab45-4e66c5facee9@gmail.com>
Date:   Tue, 1 Feb 2022 09:02:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: [PATCH 2/5] docs: pdfdocs: Switch default CJK font to KR variants
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xeCJK is enabled in Table of Contents (TOC) so that translations.pdf
built by top-level "make pdfdocs" can have its TOC typeset properly.

This causes quotation marks and apostrophe symbols appear too wide in
Latin-script docs.
This is because (1) Sphinx converts ASCII symbols into multi-byte
UTF-8 ones in LaTeX and (2) in the SC variant of "Noto CJK" font
families, those UTF-8 symbols have full-width glyph.

The KR variant of the font families has half-width glyph for those
symbols and TOC pages should look nicer when it is used instead.

Switch the default CJK font families to the KR variant and teach
xeCJK of those symbols' widths.
To compensate the switch, teach xeCJK of the width in the SC and
TC variants.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index e5c13dee2de8..e70aa5fd969f 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -460,13 +460,15 @@ latex_elements['preamble']  +=3D '''
     \\IfFontExistsTF{Noto Sans CJK SC}{
 	% This is needed for translations
 	\\usepackage{xeCJK}
-	\\IfFontExistsTF{Noto Serif CJK SC}{
-	    \\setCJKmainfont{Noto Serif CJK SC}[AutoFakeSlant]
+	\\IfFontExistsTF{Noto Serif CJK KR}{
+	    \\setCJKmainfont{Noto Serif CJK KR}[AutoFakeSlant]
 	}{
-	    \\setCJKmainfont{Noto Sans CJK SC}[AutoFakeSlant]
+	    \\setCJKmainfont{Noto Sans CJK KR}[AutoFakeSlant]
 	}
-	\\setCJKsansfont{Noto Sans CJK SC}[AutoFakeSlant]
-	\\setCJKmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]
+	\\setCJKsansfont{Noto Sans CJK KR}[AutoFakeSlant]
+	\\setCJKmonofont{Noto Sans Mono CJK KR}[AutoFakeSlant]
+	\\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}
+	\\xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}
 	% CJK Language-specific font choices
 	\\IfFontExistsTF{Noto Serif CJK SC}{
 	    \\newCJKfontfamily[SCmain]\\scmain{Noto Serif CJK SC}[AutoFakeSlant=
]
@@ -513,11 +515,18 @@ latex_elements['preamble']  +=3D '''
 	\\newcommand{\\kerneldocBeginSC}{%
 	    \\begingroup%
 	    \\scmain%
+	    \\xeCJKDeclareCharClass{FullLeft}{`=E2=80=9C,`=E2=80=98}%
+	    \\xeCJKDeclareCharClass{FullRight}{`=E2=80=9D,`=E2=80=99}%
+	    \\renewcommand{\\CJKrmdefault}{SCserif}%
+	    \\renewcommand{\\CJKsfdefault}{SCsans}%
+	    \\renewcommand{\\CJKttdefault}{SCmono}%
 	}
 	\\newcommand{\\kerneldocEndSC}{\\endgroup}
 	\\newcommand{\\kerneldocBeginTC}{%
 	    \\begingroup%
 	    \\tcmain%
+	    \\xeCJKDeclareCharClass{FullLeft}{`=E2=80=9C,`=E2=80=98}%
+	    \\xeCJKDeclareCharClass{FullRight}{`=E2=80=9D,`=E2=80=99}%
 	    \\renewcommand{\\CJKrmdefault}{TCserif}%
 	    \\renewcommand{\\CJKsfdefault}{TCsans}%
 	    \\renewcommand{\\CJKttdefault}{TCmono}%
@@ -525,8 +534,6 @@ latex_elements['preamble']  +=3D '''
 	\\newcommand{\\kerneldocEndTC}{\\endgroup}
 	\\newcommand{\\kerneldocBeginKR}{%
 	    \\begingroup%
-	    \\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}%
-	    \\xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}%
 	    \\krmain%
 	    \\renewcommand{\\CJKrmdefault}{KRserif}%
 	    \\renewcommand{\\CJKsfdefault}{KRsans}%
@@ -536,8 +543,6 @@ latex_elements['preamble']  +=3D '''
 	\\newcommand{\\kerneldocEndKR}{\\endgroup}
 	\\newcommand{\\kerneldocBeginJP}{%
 	    \\begingroup%
-	    \\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}%
-	    \\xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}%
 	    \\jpmain%
 	    \\renewcommand{\\CJKrmdefault}{JPserif}%
 	    \\renewcommand{\\CJKsfdefault}{JPsans}%
--=20
2.17.1


