Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D046E835
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbhLIMTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhLIMTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:19:37 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B9C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:16:04 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y12so18617617eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UFme8mQU1Xk2ZpZzElgnYd0Mc8+23K1aPgFRhsr4lAA=;
        b=FZqN+OqLR9qoTczfIJFxsFnF/gcXLnjuzaO9N4j7Cmarrylz+8X4cV9DI9RYNDCZbn
         H++vo6JrT5QJL7F37yUVL9Ukf6MLwg6AcfBL/l/5fhWF+HdxRHsyD9gv6up8E5ydcsgq
         dv2cmUf4f3tQdWwC2tvYv2/rQMaat1oxtAN+k1KKFTitEqW9u5jkvpdvIfQVdUS8r9jw
         vwm4VFnpUHYOEY/1G8Wh3k6HNiJ+/hulNJuiOmzV2ck98KNV3rgus9kSVhQn4pHQwwGF
         X7EDpj7aOXLD9sQmIUvGCbXtjVl7UkHI0SaYMBTF6fY93y90802uy1VEjCr85UOs3T15
         JvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=UFme8mQU1Xk2ZpZzElgnYd0Mc8+23K1aPgFRhsr4lAA=;
        b=4pCHKFxcHrIw6vRo4HKlGZlsF2Qgd4KynU1qPuxM8H9PSQHGfkXTwSBfNCkr2zye07
         OCvDiBbzrslwsayLgmuGrwTPzCl0fs2AH9iL6SgNi9pn/BJF1E3+dHSRW5SOhPPO1PGy
         4YNA9L1JlLPGXiVLM4AFTJnLbWoNrM66BqvnTu50Ggz9azNvV/INMQ2IWow09tnHbsVY
         9/FVB4YQlDFddLqDCOnEbuHQMH7B+/0JqPuvuZeAz1Z0D13QnhYtXVhchlnecuW4qj5v
         HcxVHcLcJUyccITiM1tIcUZzY+m6pGzhftsq9Fp0ueMuCVYFeK+z9yxNRBNIFRLO3rqg
         8H4g==
X-Gm-Message-State: AOAM531FSorpUotbr6JlytJPDo0aGyWb/b0HeGbgx3ZULVvCssgWc1Fh
        7wDrEafnvoRpQo7lJ6gLcyyp06rnEMHKoANkSJ4=
X-Google-Smtp-Source: ABdhPJx0jxjxG1cObdSykwZxHSYxk+yKIouhPjJRIar6UEcbXBPnX3+Q33eqPYqqm9MsIIwXDUt7Rzfsvt/8g1kTpek=
X-Received: by 2002:a17:906:c112:: with SMTP id do18mr15567416ejc.103.1639052161637;
 Thu, 09 Dec 2021 04:16:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:3bcd:0:0:0:0:0 with HTTP; Thu, 9 Dec 2021 04:16:01 -0800 (PST)
Reply-To: cristinacampeell@outlook.com
From:   "Mrs. Cristina Campbell" <topeelapopey@gmail.com>
Date:   Thu, 9 Dec 2021 12:16:01 +0000
Message-ID: <CAC3M9r8Nikhse4GgAjP6y9PqLirHRWWf6yLNUrr8Qybm_HrWKw@mail.gmail.com>
Subject: =?UTF-8?B?5L2g6IO95biu5oiR5ZCX?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5Lqy54ix55qE77yMDQoNCuivt+aFouaFouS7lOe7humYheivu++8jOWboOS4uuWug+WPr+iDveaY
r+aCqOaUtuWIsOeahOacgOmHjeimgeeahOeUteWtkOmCruS7tuS5i+S4gOOAguaIkeaYryBDcmlz
dGluYSBDYW1wYmVsbCDlpKvkurrvvIzmiJHkuI7lt7LmlYXnmoQgRWR3YXJkDQpDYW1wYmVsbCDn
u5PlqZrjgILku5bmm77lnKjkvKbmlablo7PniYznn7PmsrnlvIDlj5Hlhazlj7jlt6XkvZzvvIzk
uZ/mmK/kuIDlkI3kuJzkuprlnLDljLrnu4/pqozkuLDlr4znmoTmib/ljIXllYbjgILku5bkuo4g
MjAwMyDlubQgNyDmnIggMzENCuaXpeaYn+acn+S4gOWcqOW3tOm7juWOu+S4luOAguaIkeS7rOe7
k+WpmuS4g+W5tOayoeacieWtqeWtkOOAgg0KDQrlvZPkvaDor7vliLDov5nph4zml7bvvIzmiJHk
uI3mg7PorqnkvaDkuLrmiJHmhJ/liLDpmr7ov4fvvIzlm6DkuLrvvIzmiJHnm7jkv6Hmr4/kuKrk
urrmgLvmnInkuIDlpKnkvJrmrbvljrvjgILmiJHooqvor4rmlq3lh7rmgqPmnInpo5/pgZPnmYzv
vIzmiJHnmoTljLvnlJ/lkYror4nmiJHvvIznlLHkuo7miJHlpI3mnYLnmoTlgaXlurfpl67popjv
vIzmiJHmkpHkuI3kuoblpJrkuYXjgIINCg0K5oiR5biM5pyb5LiK5bid5oCc5oKv5oiR77yM5o6l
57qz5oiR55qE54G16a2C77yM5omA5Lul77yM5oiR5Yaz5a6a5ZCR5oWI5ZaE57uE57uHL+aVmeWg
gi/kvZvmlZnlr7rlupkv5riF55yf5a+6L+aXoOavjeWptC/lvLHlir/nvqTkvZPlkozlr6Hlpofm
lr3oiI3vvIzlm6DkuLrmiJHluIzmnJvov5nmmK/mnIDlkI7nmoTlloTooYzkuYvkuIDmiJHmrbvl
iY3lnKjlnLDnkIPkuIrlgZrjgILliLDnm67liY3kuLrmraLvvIzmiJHlt7Lnu4/lkJHoi4/moLzl
hbDjgIHlqIHlsJTlo6vjgIHlsLzms4rlsJTjgIHlt7Tmi7/pqazlkozluIzohYrnmoTkuIDkupvm
hYjlloTnu4Tnu4fmjZDmrL7jgILnjrDlnKjmiJHnmoTlgaXlurfnirblhrXmgbbljJblvpflpoLm
raTkuKXph43vvIzmiJHkuI3og73lho3oh6rlt7HlgZrov5nku7bkuovkuobjgIINCg0K5oiR5pu+
57uP6KaB5rGC5oiR55qE5a625Lq65YWz6Zet5oiR55qE5LiA5Liq6LSm5oi35bm25bCG5oiR5Zyo
6YKj6YeM55qE6ZKx5YiG6YWN57uZ5Lit5Zu944CB57qm5pem44CB5b635Zu944CB6Z+p5Zu95ZKM
5pel5pys55qE5oWI5ZaE57uE57uH77yM5LuW5Lus5ouS57ud5bm25bCG6ZKx55WZ57uZ6Ieq5bex
44CC5Zug5q2k77yM5oiR5rKh5pyJ5LiN5YaN55u45L+h5LuW5Lus77yM5Zug5Li65LuW5Lus5Ly8
5LmO5LiN5Lya5LiO5oiR5Li65LuW5Lus55WZ5LiL55qE5Lic6KW/5oqX6KGh44CC5oiR5pyA5ZCO
5LiA56yU5peg5Lq655+l6YGT55qE6ZKx5piv5oiR5Zyo5rOw5Zu95LiA5a626ZO26KGM5a2Y5YWl
55qEDQo2MDAg5LiH576O5YWD55qE5beo6aKd546w6YeR5a2Y5qy+44CC5aaC5p6c5oKo55yf6K+a
77yM5oiR5biM5pyb5oKo5bCG6L+Z56yU6LWE6YeR55So5LqO5oWI5ZaE6K6h5YiS5bm25pSv5oyB
5oKo5omA5Zyo5Zu95a62L+WcsOWMuueahOS6uuexu+OAgg0KDQrmiJHlgZrov5nkuKrlhrPlrprm
mK/lm6DkuLrmiJHmsqHmnInlranlrZDkvJrnu6fmib/ov5nnrJTpkrHvvIzmiJHkuI3mgJXmrbvv
vIzmiYDku6XmiJHnn6XpgZPmiJHopoHljrvlk6rph4zjgILmiJHnn6XpgZPmiJHkvJrlnKjkuLvn
moTmgIDmirHph4zjgILmlLbliLDmgqjnmoTlm57lpI3lkI7vvIzmiJHkvJrlsL3lv6vnu5nmgqjp
k7booYznmoTogZTns7vmlrnlvI/vvIzlubblkJHmgqjlj5Hlh7rmjojmnYPkuabvvIzmjojmnYPm
gqjmiJDkuLror6Xln7rph5HnmoTljp/lp4vlj5fnm4rkurrvvIzku6Xkvr/mgqjnq4vljbPlnKjm
gqjmiYDlnKjnmoTlm73lrrYv5Zyw5Yy65byA5aeL6L+Z6aG55oWI5ZaE6K6h5YiS44CCDQoNCuWP
quacieS4uuS7luS6uuiAjOa0u+eahOS6uueUn+aJjeaYr+acieS7t+WAvOeahOOAguaIkeW4jOac
m+S9oOawuOi/nOS4uuaIkeeliOelt++8jOS9oOWbnuWkjeeahOS7u+S9leW7tui/n+mDveS8muiu
qeaIkeacieepuumXtOS4uuWQjOagt+eahOebrueahOWvu+aJvuWPpuS4gOS4quS6uuOAguWmguae
nOaCqOS4jeaEn+WFtOi2o++8jOivt+WOn+iwheaIkeS4juaCqOiBlOezu+OAguaCqOWPr+S7pemA
mui/h+aIkeeahOengeS6uueUteWtkOmCruS7tuiBlOezu+aIluWbnuWkjeaIke+8mihjcmlzdGlu
YWNhbXBlZWxsQG91dGxvb2suY29tKeOAgg0KDQrosKLosKLvvIwNCuatpOiHtO+8jA0K5YWL6YeM
5pav6JKC5aicwrflnY7otJ3lsJTlpKvkuroNCueUteWtkOmCruS7tjsgY3Jpc3RpbmFjYW1wZWVs
bEBvdXRsb29rLmNvbQ0K
